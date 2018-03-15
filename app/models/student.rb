# -*- encoding : utf-8 -*-
class Student < ActiveRecord::Base
  #Connections with other model classes:
  belongs_to :group
  has_many :results, :dependent => :destroy

  #Validations:
  validates_presence_of :name, :gender
  after_create :set_login, :set_group_type
  validates_uniqueness_of :name, scope: :group_id


  serialize :achievement, Hash


  #Getter für Merkmale:

  def get_gender(raw = false)
    return self[:gender]
  end

  def get_birthdate(raw = false)
    if self[:birthdate].nil?
      return raw ? "nicht erfasst" : "<i>nicht erfasst</i>"
    else
      return I18n.l(self[:birthdate].to_date, format: "%b %Y")
    end
  end

  def get_specific_needs(raw = false)
    if self[:specific_needs].nil?
      return raw ? "nicht erfasst" : "<i>nicht erfasst</i>"
    else
      return case self[:specific_needs]
        when 0 then "Keinen"
        when 1 then "Lernen"
        when 2 then "Geistige Entwicklung"
        when 3 then "Anderer Förderbedarf"
        when 4 then "Deutsch"
      end
    end
  end

  def get_migration(raw = false)
    return self[:migration].nil? ? (raw ? "nicht erfasst" : "<i>nicht erfasst</i>") : (self[:migration] ? "Ja" : "Nein")
  end


  #####################

  #Generate random login code
  def set_login
    while self.login.nil? | self.login.blank?
      self.login = self.name
      self.save
    end
  end

  def set_group_type
    if self.group_type.nil? |self.group_type.blank?
      self.group_type = 0
      self.save
    end
  end

  def self.table_headings
    return %w{ID Code Probandengruppen-Id Probandengruppen-Name Benutzer-Id Geschlecht Geburtsdatum Förderbedarf Migrationshintergrund}
  end

  def to_a
    return [id.to_s, name, group.id, group.name, group.user.id, get_gender(true), get_birthdate(true), get_specific_needs(true), get_migration(true)]
  end

  def self.import(file, group)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    header.each{|h| h.downcase!}
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = group.students.build(name: row["name"])
      student.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def getResults
    tests = Hash.new()
    items = Hash.new()
    results.each do |r|
      if r.score == nil
        next
      end
      test = r.measurement.assessment.test.id
      if tests.has_key?(test)
        tests[test] = tests[test] + [r]
      else
        tests[test] = [r]
      end
      for i in 0..r.responses.size-1 do
        item = r.items[i].to_s
        val = r.responses[i]
        if items.has_key?(item)
          items[item]["freq"] = items[item]["freq"] + 1
          items[item]["cor"] = items[item]["cor"] + (val == nil ? 0 : val)
          items[item]["prob"] = items[item]["cor"].to_f / items[item]["freq"]
          items[item]["dates"] = items[item]["dates"] + [r.measurement.date]
        else
          items[item] = {"freq" => 1,"cor" => (val == nil ? 0 : val), "prob" => (r.responses[i] == nil ? 0 : r.responses[i]), "dates" => [r.measurement.date]}
        end
        i = i + 1
      end
    end
    return tests
  end

  def getTestResults(test_id)
    items = Hash.new()
    results.each do |r|
      if test_id == r.measurement.assessment.test.id
        for i in 0..r.responses.size-1 do
          item = r.items[i].to_s
          val = r.responses[i]
          if items.has_key?(item)
            items[item]["freq"] = items[item]["freq"] + 1
            items[item]["cor"] = items[item]["cor"] + (val == nil ? 0 : val)
            items[item]["prob"] = items[item]["cor"].to_f / items[item]["freq"]
            items[item]["dates"] = items[item]["dates"] + [r.measurement.date]
          else
            items[item] = {"freq" => 1,"cor" => (val == nil ? 0 : val), "prob" => (r.responses[i] == nil ? 0 : r.responses[i]), "dates" => [r.measurement.date]}
          end
          i = i + 1
        end
      end
    end
    probs = []
    items.each do |key, val|
      probs = probs + [val["prob"]]
    end
    probs.sort!
    return {"1st" => probs[probs.size/4], "4th" => probs[3*probs.size/4], "data" => items}
  end

  #Only get measurement which are available
  def get_open_assessments
    t = Test.where(:student_access => true)
    a = Assessment.where(:group => self.group.id).
                   where(:test => t)

	return a
  end

  def get_data_ranking()
    potential_group = Student.where(group_id:self.group_id)
    group_size = potential_group.size
    if(group_size>5)
      i=0
      result_group= []
      check_diff_point_group = 0
      while result_group.size < 5  do
        result_group = potential_group.
            where('played_questions< :max_played AND played_questions > :min_played',max_played:self.played_questions+i, min_played:self.played_questions-i)
        check_diff_point_group = result_group.pluck(:points).uniq.size
        if(check_diff_point_group<5 && result_group.size!=potential_group.size)
          result_group = []
        end
        i = i+1
      end
    else
      i=0
      result_group= []
      while result_group.size < group_size do
        result_group =
            potential_group.
                where('played_questions< :max_played AND played_questions > :min_played',max_played:self.played_questions+i, min_played:self.played_questions-i)
        i = i+1
      end
    end
    if(result_group.size==0)
      return result_group
    else
      return result_group.order(points: :desc)
    end

  end

  #get current result objekt of student
  def getCurrentResult(measurement_id)
    r = Result.where(:student_id => self.id, :measurement_id => measurement_id).first
    return r.nil? ? [] : r
  end

  def self.prepare_new_student(group, ip, fingerprint)
    achievement = {"a1"=>[false, "/images/Badges/empty.png", "/images/Badges/welt_bronze.png","","Erstes Geographie-Quiz durchgeführt."], "a2"=>[false, "/images/Badges/empty.png", "/images/Badges/welt_silber.png","","50% der Geographie-Fragen kennengelernt."],"a3"=>[false, "/images/Badges/empty.png", "/images/Badges/welt_gold.png","" ,"90% der Geographie-Fragen kennengelernt."],
                   "a4"=>[false, "/images/Badges/empty.png", "/images/Badges/mathe_bronze.png","","Erstes Mathe-Quiz durchgeführt."],"a5"=>[false, "/images/Badges/empty.png", "/images/Badges/mathe_silber.png","","50% der Mathe-Fragen kennengelernt."], "a6"=>[false, "/images/Badges/empty.png", "/images/Badges/mathe_gold.png","","90% der Mathe-Fragen kennengelernt."],
                   "a7"=>[false, "/images/Badges/erste_frage.png", "/images/Badges/erste_frage_bronze.png","noch nicht erreicht: Erste Frage richtig beantwortet.","Erste Frage richtig beantwortet."], "a8"=>[false, "/images/Badges/email.png", "/images/Badges/email_bronze.png","noch nicht erreicht: Logincode per Email zugeschickt.","Logincode per Email zugeschickt."],
                   "a9"=>[false, "/images/Badges/empty.png", "/images/Badges/geoCor_silber.png","","Sonnensystem-Frage richtig beantwortet."], "a10"=>[false, "/images/Badges/empty.png", "/images/Badges/matheCor_silber.png", "","Pi-Frage richtig beantwortet."],
                   "a11"=>[false, "/images/Badges/empty.png", "/images/Badges/politik_bronze.png","","Erstes Politik-Quiz durchgeführt."],"a12"=>[false, "/images/Badges/empty.png", "/images/Badges/politik_silber.png","","50% der Politik-Fragen kennengelernt."], "a13"=>[false, "/images/Badges/empty.png", "/images/Badges/politik_gold.png","","90% der Politik-Fragen kennengelernt."],
                   "a14"=>[false, "/images/Badges/empty.png", "/images/Badges/sport_bronze.png", "", "Erstes Sport-Quiz durchgeführt."], "a15"=>[false, "/images/Badges/empty.png", "/images/Badges/sport_silber.png","","50% der Sport-Fragen kennengelernt."], "a16"=>[false, "/images/Badges/empty.png", "/images/Badges/sport_gold.png", "", "90% der Sport-Fragen kennengelernt."],
                   "a17"=>[false, "/images/Badges/haus.png", "/images/Badges/haus_silber.png", "noch nicht erreicht: Erfolgreich erneut eingeloggt.","Erfolgreich erneut eingeloggt."],"a18"=>[false, "/images/Badges/kiel.png", "/images/Badges/kiel_silber.png", "noch nicht erreicht: Kiel-Frage richtig beantwortet.","Kiel-Frage richtig beantwortet."],
                   "a19"=>[false, "/images/Badges/empty.png", "/images/Badges/politikCor_silber.png","","Karlsruhe-Frage richtig beantwortet."], "a20"=>[false, "/images/Badges/empty.png", "/images/Badges/sportCor_silber.png","","Olympia-Frage richtig beantwortet."],
                   "a21" => [false, "/images/Badges/empty.png", "/images/Badges/tier_pflanze_bronze.png", "", "Erstes Tiere&Pflanzen-Quiz durchgeführt."], "a22"=>[false, "/images/Badges/empty.png", "/images/Badges/tier_pflanze_silber.png", "", "50% der Tiere&Pflanzen-Fragen kennengelernt."],"a23"=>[false, "/images/Badges/empty.png", "/images/Badges/tier_pflanze_gold.png","","90% der Tiere&Pflanzen-Fragen kennengelernt."],
                   "a24"=>[false, "/images/Badges/empty.png", "/images/Badges/social_media_bronze.png","","Erstes Web-Quiz durchgeführt."], "a25"=>[false, "/images/Badges/empty.png", "/images/Badges/social_media_silber.png","","50% der Web-Fragen kennengelernt."], "a26"=>[false, "/images/Badges/empty.png", "/images/Badges/social_media_gold.png","","90% der Web-Fragen kennengelernt."],
                   "a27"=>[false, "/images/Badges/quizmaster.png", "/images/Badges/quizmaster_gold.png","noch nicht erreicht: Quizmaster! Alle versteckten Abzeichen erhalten.","Quizmaster! Alle versteckten Abzeichen erhalten."],"a28"=>[false, "/images/Badges/fragebogen.png", "/images/Badges/fragebogen_gold.png", "noch nicht erreicht: Feedback abgeschickt.", "Feedback abgeschickt."],
                   "a29"=>[false, "/images/Badges/empty.png", "/images/Badges/tierPflanzenCor_silber.png","","Fliegenpilz-Frage richtig beantwortet."], "a30"=>[false, "/images/Badges/empty.png", "/images/Badges/socialMediaCor_silber.png", "", "WLAN-Frage richtig beantwortet."]}
    testLoginFree = true
    while testLoginFree
      cur = (('0'..'9').to_a + ('a'..'z').to_a).shuffle.first(6).join
      if(Student.where(:login => cur).empty?)
        testLoginFree=false
      end
    end
    s = group.students.build(name: cur, group_type: Random.rand(6),feedback_send:false,survey_done:false, login_times:0, ip: ip, fingerprint: fingerprint, gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
    s.save
    return s
  end



end

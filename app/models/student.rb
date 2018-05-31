# -*- encoding : utf-8 -*-
#Klasse für die Probanden
class Student < ActiveRecord::Base
  #Jeder gehört zu einer Studie
  belongs_to :group
  #Zerstöre alle zugehörigen Ergebnisse, wenn der Proband zerstört wird
  has_many :results, :dependent => :destroy

  #Mindestens der Name und das Geschlecht müssen vorhanden sein
  validates_presence_of :name, :gender

  #Jeder Name muss eindeutig sein innerhalb einer Gruppe <-z.B. Username eindeutig
  validates_uniqueness_of :name, scope: :group_id

  #Hash für die Badges
  serialize :achievement, Hash


  #Zurückgeben des Geschlechts
  def get_gender(raw = false)
    return self[:gender]
  end

  #Zurückgeben aller Ergebnisse
  #nötig um den graphen richtig anzuzeigen und
  # auf der stundentshow-Seite alle daten richtig anzuzeigen
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

  #Zurückgeben der Ergebnisse füe einen Test
  #nötig um den graphen richtig anzuzeigen und
  # auf der stundentshow-Seite alle daten richtig anzuzeigen
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

  #Zurückgeben aler verfügbaren assessments
  def get_open_assessments
    t = Test.all
    a = Assessment.where(:group => self.group.id).
                   where(:test => t)

	return a
  end

  #Erhalten der benötigten Daten fürs Ranking
  #Erhalten von 5-6 "Punktegruppen"
  def get_data_ranking()
    potential_group = Student.where(group_id:self.group_id)
    group_size = potential_group.size
    #Wenn die Gruppengröße kleiner als 5 ist direkt zurückgeben<-es kann nur max. 5 Punktegruppen geben
    if(group_size>5)
      i=0
      result_group= []
      check_diff_point_group = 0
      #Erzeugen eines Array mit 5-6 verschiedenen Gruppen
      while result_group.size < 5  do
        result_group = potential_group.
            where('points< :max_points AND points > :min_points',max_points:self.points+i, min_points:self.points-i)
        check_diff_point_group = result_group.pluck(:points).uniq.size
        if(check_diff_point_group<5 && result_group.size!=potential_group.size)
          result_group = []
        end
        i = i+1
      end
      result_group= result_group.order(points: :desc)
      #Man selber soll nie in der ersten oder letzten Gruppe sein, welche angezeigt wird.
      #Außnahme: Man ist auf dem ersten oder letzten "Platz"
      if(result_group.first.points == self.points)
        #erster Platz?
        group_before_me = potential_group.where('points> :my_points', my_points:self.points).order(points: :asc)
        if(group_before_me.size ==0)
        else
          result_group = result_group.where.not(points:result_group.last.points)
          group_before_me = potential_group.where(points: group_before_me.first.points).order(points: :desc)
          result_group = result_group.or(group_before_me)
        end
        #letzter Platz?
      elsif(result_group.last.points == self.points)
        group_after_me = potential_group.where('points< :my_points', my_points:self.points).order(points: :desc)
        if(group_after_me.size ==0)
        else
          result_group = result_group.where.not(points:result_group.first.points)
          group_after_me = potential_group.where(points: group_after_me.first.points).order(points: :desc)
          result_group = result_group.or(group_after_me)
        end
      else
        #everything perfect
      end
    else
      result_group = potential_group
    end
    return result_group
  end

  #get current result objekt of student
  def getCurrentResult(measurement_id)
    r = Result.where(:student_id => self.id, :measurement_id => measurement_id).first
    return r.nil? ? [] : r
  end

  #Initialisieren eines Probanden
  #Eingabe Studie (Group-Objekt), Ip-Adresse, Browserhash
  def self.prepare_new_student(group, ip, fingerprint)
    #Initialisieren des Hash für die Badges
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
    #Zuweisen eines individuellen Logins
    testLoginFree = true
    while testLoginFree
      cur = (('0'..'9').to_a + ('a'..'z').to_a).shuffle.first(6).join
      if(Student.where(:login => cur).empty?)
        testLoginFree=false
      end
    end
    #Erzeugen des Probanden
    s = group.students.build(name: cur, login: cur, group_type: Random.rand(group.test_condition_count),feedback_send:false,survey_done:false, login_times:0, ip: ip, fingerprint: fingerprint, gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
    s.save
    return s
  end
end

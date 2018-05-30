# -*- encoding : utf-8 -*-

require 'spreadsheet'
#Klasse für die Tests
class Test < ActiveRecord::Base
  #Jeder Hat viele Items und assessment, welche zerstört werden
  #wenn der Test zerstört wird
  has_many :items, :dependent => :destroy
  has_many :assessments, :dependent => :destroy

  #Besitzt mindestens einen namen, eine ansiedelndes Gebiet z.B. Schulfach, besitzt einen Schwerpunkt auf dem der test abzielt
  #z.B. Quiz, Klassifizieren, Lesen, ....
  validates_presence_of :name
  validates_presence_of :subject
  validates_presence_of :construct


  #Erhalten aller zu testenden Items für den Test
  def content_items
    self.items.where(itemtype: 0).order(:id)
  end

  #Erhalten aller Startitems für den Test
  def intro_items
    self.items.where("itemtype < ?", 0).order(:itemtype)
  end

  #Erhalten aller Enditems für den test
  def outro_items
    self.items.where("itemtype > ?", 0).order(:itemtype)
  end

  #Ziehen der Items für einen Testdurchlauf
  def draw_items(oldItems)
    minNewItems = 15
    # -> ziehe immer (hier 15) unbekannte Items
    if false || self.name == "BFI"                          #Nett um zu testen (einfach auf true setzen)
      itemset = content_items
    else
      #ziehen potenzieller Kanditaten an neuen Items
      newItems = content_items - oldItems
      canidateItems = Array.new
      if(newItems.size>minNewItems)
        minNewItems.times do
          canidateItems = canidateItems + [newItems.sample]
          newItems = newItems -canidateItems

        end
      else
        #alle neuen zurückgeben (Anzahl unter 15)
        canidateItems = newItems
      end
      #Wenn es noch neue Items gibt (zwischen 1-15)
      #Ziehe restliche item um auf 20 zu kommen
        #dadurch auch 15+ neue Items möglich
      if(canidateItems.size >= 0)
        (20-canidateItems.size).times do
          remaining = content_items - canidateItems
          canidateItems = canidateItems + [remaining.sample]
        end
      else
        canidateItems = content_items
      end
      #ziehen einfach 20 items (alle bekannt)
      itemset = Array.new
      20.times do   # Folgende Ziehungen: Zufällig permutieren
        remaining = canidateItems - itemset
        itemset = itemset + [remaining.sample]
      end
    end
    return [intro_items.map{|i| i.id}, itemset.map{|i| i.id}, outro_items.map{|i| i.id}]
  end

  #Länge des Test zurückgeben
  def len_info
    if time.nil?
      return "#{len} Items"
    else
      return "#{time} Sekunden, max. #{len} Items"
    end
  end

  #In welcher View soll der Test ablaufen
  def view_info
    return 'Generisch'
  end

  #Wie ist der ganze Name des Test mit Gebiet und Schwerpunkt
  def long_name
    return name + ' - ' +  ' (' + subject + ' - ' + construct + ')'
  end

  #Kurname des test(normaler name)
  def short_name
    return name
  end

  def code
    name.split(' ').map{|w| w.slice(0, 2)}.join
  end

  #Count number of assessments for each test by a direct SQL query, to save time. Returns a hash that maps test ids to counts.
  def self.get_assessment_count
    temp = ActiveRecord::Base.connection.exec_query("
      SELECT test_id, COUNT(*) as Anzahl
      FROM tests JOIN assessments ON tests.id = test_id
        JOIN groups ON groups.id = group_id
        JOIN users ON users.id = user_id
      WHERE export = 1
      GROUP BY test_id;
    ")
    ids = temp.map{|x| x["test_id"]}
    count = temp.map{|x| x["Anzahl"]}
    return Hash[ids.zip(count)]
  end

  #Count number of measurements for each test by a direct SQL query, to save time. Returns a hash that maps test ids to counts.
  def self.get_measurement_count
    temp = ActiveRecord::Base.connection.exec_query("
      SELECT test_id, COUNT(*) as Anzahl
      FROM measurements JOIN assessments ON assessments.id = assessment_id
        JOIN groups ON groups.id = group_id
        JOIN users ON users.id = user_id
      WHERE export = 1
      GROUP BY test_id;
    ")
    ids = temp.map{|x| x["test_id"]}
    count = temp.map{|x| x["Anzahl"]}
    return Hash[ids.zip(count)]
  end

  #Count number of results for each test by a direct SQL query, to save time. Returns a hash that maps test ids to counts.
  def self.get_result_count
    temp = ActiveRecord::Base.connection.exec_query("
      SELECT test_id, COUNT(*) as Anzahl
      FROM results JOIN measurements ON measurements.id = measurement_id
        JOIN assessments ON assessments.id = assessment_id
        JOIN groups ON groups.id = group_id
        JOIN users ON users.id = user_id
      WHERE export = 1
      GROUP BY test_id;
    ")
    ids = temp.map{|x| x["test_id"]}
    count = temp.map{|x| x["Anzahl"]}
    return Hash[ids.zip(count)]
  end
end
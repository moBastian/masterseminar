# -*- encoding : utf-8 -*-
#Klasse für die Messzeitpunkte
class Measurement < ActiveRecord::Base
  #Jedes gehört genau zu einen Assessment
  belongs_to :assessment
  #Kann viele Ergebnisse und Probanden haben
  #Zerstöre das Ergebnis, wenn der Messzeitpunkt zerstört wird
  has_many :results, :dependent => :destroy
  has_many :students, through: :results

  #Mindestens das Datum muss vorhanden sein
  validates_presence_of :date


  #Default model order: By (due) date.
  default_scope {order('date DESC')}

  #Vorbereiten eines Messzeitpunkt
    #Erzeugen eines Ergebnisobjektes für den übergebenen Probanden
  def prepare_test(currentStudent)
    r = results.build(student: currentStudent)
    r.initialize_results()
  end

  #Updaten
  def update_students(hash)
    hash.each do  |name, id|
      s = Student.find(id.to_i)
      if (not s.nil?) && s.name == name && s.group == assessment.group && results.where(:student_id => s.id).blank?
        r = results.build(student: s)
        r.initialize_results()
      end
    end
    students.each do |s|
      unless hash.has_key?(s.name)
        r = results.find_by_student_id(s.id)
        unless r.nil?
          r.destroy
        end
      end
    end
  end

  #Wieviele Ergebnisse wurden bis jetzt bearbeitet
  def real_results
    x = results.map{|f| f.score} - [nil]
    return x.count
  end

  #Durchschnittliche Lösungswahrscheinlichkeit
  def average
    return ((results.map{|f| f.score.nil? ? 0 : f.score}.sum).to_f/real_results).round(1)
  end

  #Geringste Lösungsanzahl
  def min
    return results.map{|f| f.score.nil? ? 0 : f.score}.min
  end

  #Größte Lösungsanzahl
  def max
    return results.map{|f| f.score.nil? ? 0 : f.score}.max
  end

end

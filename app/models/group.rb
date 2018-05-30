# -*- encoding : utf-8 -*-
#Klasse für die Studien
class Group < ActiveRecord::Base
  #Gehören genau zu einen Nutzer
  belongs_to :user
  #Zerstöre alle Probanden, Assessments, Kommentare, wenn die zugehörige Gruppe gelöscht wird
  has_many :students, :dependent => :destroy
  has_many :assessments, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
  #Muss einen namen haben, welcher eindeutig für einen Nutzer ist
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user_id
  #Rufe set_defaults nach dem erzeugen der Gruppe auf
  after_create :set_defaults

  #Setzen des default-Wertes für das Archivierungs-Flag
  def set_defaults
      self.archive ||= false
  end


end

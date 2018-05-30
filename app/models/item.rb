# -*- encoding : utf-8 -*-
#Klasse für die Items
class Item < ActiveRecord::Base
  #Jedes gehört genau zu einen Test
  belongs_to :test
  #Mindestens der Itemtext muss vorhanden sein
  validates_presence_of :itemtext
  #Führe die Methode check_shorthand aus vor jedem Speichern des Items
  before_save :check_shorthand



  private
  #Belegt den shorthand mti dem itemtext, wenn der shorthand leer ist
  def check_shorthand
    if shorthand.nil? || shorthand.blank?
      self.shorthand = itemtext
    end
  end


end

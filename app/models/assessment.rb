# -*- encoding : utf-8 -*-
#Assessmentklassse
class Assessment < ActiveRecord::Base
  #Wenn das Assessment zerstört wird, zerstöre auch alle zugehörigen Messzeitpunkte
  has_many :measurements, :dependent => :destroy
  #gehört zu einer Studie und zu einem Test
  belongs_to :test
  belongs_to :group
end

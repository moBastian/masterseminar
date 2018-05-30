#Klasse für das Feedback der Probanden
class Feedback < ActiveRecord::Base
  #Jedes gehört genau zu einer Gruppe
  belongs_to :groups

end

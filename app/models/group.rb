# -*- encoding : utf-8 -*-
class Group < ActiveRecord::Base
  belongs_to :user
  has_many :students, :dependent => :destroy
  has_many :assessments, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user_id

  after_create :set_defaults, :setName

  def set_defaults
      self.archive ||= false
  end

  def setName
    self.name = self.user_id.to_s + self.name
    self.save
  end

end

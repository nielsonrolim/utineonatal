class Indicator < ActiveRecord::Base
  belongs_to :indicator_category
  has_many :indicator_visits
  has_many :visits, through: :indicator_visits
  has_and_belongs_to_many :diagnoses

  validates_presence_of :name, :indicator_category

  def has_obs_for_visit?(visit_id)
    unless self.obs(visit_id).nil?
      return !self.obs(visit_id).empty?
    else
      return false
    end
  end

  def obs(visit_id)
    IndicatorVisit.where('indicator_id = ? and visit_id = ?', self.id, visit_id).first.obs
  end
end

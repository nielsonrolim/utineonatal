class Indicator < ActiveRecord::Base
  belongs_to :indicator_category
  has_many :indicator_visits
  has_many :visits, through: :indicator_visits
  has_and_belongs_to_many :diagnoses
end

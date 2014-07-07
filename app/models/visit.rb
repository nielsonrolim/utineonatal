class Visit < ActiveRecord::Base
  belongs_to :hospitalization
  has_many :indicator_visits
  has_many :indicators, through: :indicator_visits
  has_and_belongs_to_many :diagnoses
  has_and_belongs_to_many :interventions
  belongs_to :user
end

class Visit < ActiveRecord::Base
  belongs_to :hospitalization
  has_many :indicator_visits
  has_many :indicators, through: :indicator_visits
  has_and_belongs_to_many :diagnoses
  has_and_belongs_to_many :interventions
  belongs_to :user

  self.per_page = 30

  validates_presence_of :temperature, :incubator_temperature, :pulse, :heart_rate, :respiratory_rate
end

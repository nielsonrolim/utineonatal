class Visit < ActiveRecord::Base
  belongs_to :hospitalization
  has_many :indicator_visits
  has_many :indicators, through: :indicator_visits
end

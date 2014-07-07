class Diagnosis < ActiveRecord::Base
  has_and_belongs_to_many :visits
  has_and_belongs_to_many :indicators
  has_and_belongs_to_many :interventions
end

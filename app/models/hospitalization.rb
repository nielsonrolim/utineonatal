class Hospitalization < ActiveRecord::Base
  belongs_to :bed
  belongs_to :patient
  has_many :visits

  self.per_page = 30
end

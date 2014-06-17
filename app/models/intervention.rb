class Intervention < ActiveRecord::Base
  has_many :visits
  has_and_belongs_to_many :diagnoses
end

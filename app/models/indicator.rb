class Indicator < ActiveRecord::Base
  belongs_to :indicator_category
  has_and_belongs_to_many :diagnoses
end

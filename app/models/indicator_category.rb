class IndicatorCategory < ActiveRecord::Base
  has_many :indicators

  validates_presence_of :name
  validates_uniqueness_of :name
end

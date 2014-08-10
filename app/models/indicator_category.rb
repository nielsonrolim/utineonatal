class IndicatorCategory < ActiveRecord::Base
  has_many :indicators
  belongs_to :parent, :class_name => 'IndicatorCategory', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'IndicatorCategory', :foreign_key => 'parent_id'

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.main_categories
    self.where('parent_id is NULL').order('name')
  end
end

class IndicatorCategory < ActiveRecord::Base
  has_many :indicators
  belongs_to :parent, :class_name => 'IndicatorCategory', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'IndicatorCategory', :foreign_key => 'parent_id'

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.main_categories
    self.where('parent_id is NULL').order('name')
  end

  def all_indicators
    self.children.collect { |ch| ch.indicators }.flatten
  end

  def children_ordered_by_name
    children = self.children.order(:name).to_a
    category_named_other = children.select {|c| c.name.downcase.include? 'outros'}.first
    unless category_named_other.nil?
      children.delete_if {|c| c.id == category_named_other.id}
      children.push category_named_other
    end
    return children
  end

  def any_indicator_in_array?(a)
    indicators_ids = self.all_indicators.collect {|c| c.id}
    indicators_ids.each do |id|
      if a.include? id
        return true
      end
    end
    return false
  end
end


class AddExclusiveOptionsToIndicatorCategory < ActiveRecord::Migration
  def change
    add_column :indicator_categories, :exclusive_options, :boolean
  end
end

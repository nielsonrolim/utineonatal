class AddParentIdToIndicatorCategories < ActiveRecord::Migration
  def change
    add_column :indicator_categories, :parent_id, :integer
  end
end

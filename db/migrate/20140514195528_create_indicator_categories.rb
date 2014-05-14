class CreateIndicatorCategories < ActiveRecord::Migration
  def change
    create_table :indicator_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

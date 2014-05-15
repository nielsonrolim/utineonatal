class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :obs_description
      t.boolean :has_obs
      t.integer :indicator_category_id

      t.timestamps
    end
  end
end

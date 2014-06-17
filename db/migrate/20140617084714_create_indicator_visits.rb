class CreateIndicatorVisits < ActiveRecord::Migration
  def change
    create_table :indicator_visits do |t|
      t.string :obs
      t.belongs_to :indicator, index: true
      t.belongs_to :visit, index: true

      t.timestamps
    end
  end
end

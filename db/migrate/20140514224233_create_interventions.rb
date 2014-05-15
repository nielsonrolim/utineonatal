class CreateInterventions < ActiveRecord::Migration
  def change
    create_table :interventions do |t|
      t.string :name

      t.timestamps
    end
  end
end

class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.datetime :datahora
      t.integer :hospitalization_id
      t.integer :user_id

      t.timestamps
    end
  end
end

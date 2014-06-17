class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.date :birthdate
      t.string :sex

      t.timestamps
    end
  end
end

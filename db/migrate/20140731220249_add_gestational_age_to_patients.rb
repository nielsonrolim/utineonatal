class AddGestationalAgeToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :gestational_age, :string
  end
end

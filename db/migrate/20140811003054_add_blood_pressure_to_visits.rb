class AddBloodPressureToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :blood_pressure_min, :integer
    add_column :visits, :blood_pressure_max, :integer
  end
end

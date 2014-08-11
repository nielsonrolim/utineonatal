class AddIncubatorTemperatureToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :incubator_temperature, :decimal, precision: 2
  end
end

class AddTransportConditionsToHospitalizations < ActiveRecord::Migration
  def change
    add_column :hospitalizations, :transport_conditions, :string
  end
end

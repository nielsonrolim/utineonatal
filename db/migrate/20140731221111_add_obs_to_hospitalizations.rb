class AddObsToHospitalizations < ActiveRecord::Migration
  def change
    add_column :hospitalizations, :obs, :text
  end
end

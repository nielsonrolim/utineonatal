class AddOriginToHospitalizations < ActiveRecord::Migration
  def change
    add_column :hospitalizations, :origin, :string
  end
end

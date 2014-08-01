class AddReasonToHospitalizations < ActiveRecord::Migration
  def change
    add_column :hospitalizations, :reason, :text
  end
end

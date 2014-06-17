class CreateHospitalizations < ActiveRecord::Migration
  def change
    create_table :hospitalizations do |t|
      t.datetime :checkin
      t.datetime :checkout
      t.integer :patient_id
      t.integer :bed_id

      t.timestamps
    end
  end
end

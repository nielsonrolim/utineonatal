class AddMedicalRecordNumberToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :medical_record_number, :string
  end
end

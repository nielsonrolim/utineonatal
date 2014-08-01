class AddBloodTypeToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :blood_type, :string
  end
end

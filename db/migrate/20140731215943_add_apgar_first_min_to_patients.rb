class AddApgarFirstMinToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :apgar_first_min, :string
  end
end

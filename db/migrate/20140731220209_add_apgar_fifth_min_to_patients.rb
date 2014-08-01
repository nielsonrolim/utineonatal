class AddApgarFifthMinToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :apgar_fifth_min, :string
  end
end

class AddChildbirthTypeToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :childbirth_type, :string
  end
end

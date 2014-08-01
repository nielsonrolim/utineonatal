class ChangeBirthdateFormatInPatients < ActiveRecord::Migration
  def up
    change_column :patients, :birthdate, :datetime
  end

  def down
    change_column :patients, :birthdate, :date
  end
end

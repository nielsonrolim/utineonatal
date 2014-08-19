class ChangePulseTypeToIntegerInVisits < ActiveRecord::Migration
  def up
    change_column :visits, :pulse, :integer
  end

  def down
    change_column :visits, :pulse, :decimal, precision: 2
  end
end

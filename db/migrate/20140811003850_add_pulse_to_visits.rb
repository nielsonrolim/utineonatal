class AddPulseToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :pulse, :decimal, precision: 2
  end
end

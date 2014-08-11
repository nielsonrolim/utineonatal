class AddWeightToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :weight, :decimal, precision: 2
  end
end

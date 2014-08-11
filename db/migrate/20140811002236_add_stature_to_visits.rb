class AddStatureToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :stature, :decimal, precision: 2
  end
end

class AddHeadCircumferenceToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :head_circumference, :decimal, precision: 2
  end
end

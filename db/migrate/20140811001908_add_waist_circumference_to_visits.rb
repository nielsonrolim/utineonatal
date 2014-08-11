class AddWaistCircumferenceToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :waist_circumference, :decimal, precision: 2
  end
end

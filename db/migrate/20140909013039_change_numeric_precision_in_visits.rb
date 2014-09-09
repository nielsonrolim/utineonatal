class ChangeNumericPrecisionInVisits < ActiveRecord::Migration
  def change
  	change_column :visits, :weight, :decimal, precision: 6, scale: 2
  	change_column :visits, :stature, :decimal, precision: 6, scale: 2
  	change_column :visits, :head_circumference, :decimal, precision: 6, scale: 2
  	change_column :visits, :thoracic_perimeter, :decimal, precision: 6, scale: 2
  	change_column :visits, :waist_circumference, :decimal, precision: 6, scale: 2
  	change_column :visits, :temperature, :decimal, precision: 6, scale: 2
  end
end

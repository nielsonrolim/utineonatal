class AddThoracicPerimeterToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :thoracic_perimeter, :decimal, precision: 2
  end
end

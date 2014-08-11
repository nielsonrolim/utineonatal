class AddRespiratoryRateToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :respiratory_rate, :integer
  end
end

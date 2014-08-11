class AddHeartRateToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :heart_rate, :integer
  end
end

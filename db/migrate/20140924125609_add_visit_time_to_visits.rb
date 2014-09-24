class AddVisitTimeToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :visit_time, :integer
  end
end

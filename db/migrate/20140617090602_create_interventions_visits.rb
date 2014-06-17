class CreateInterventionsVisits < ActiveRecord::Migration
  def change
    create_table :interventions_visits, id: false do |t|
      t.belongs_to :intervention, index: true
      t.belongs_to :visit, index: true
    end
  end
end

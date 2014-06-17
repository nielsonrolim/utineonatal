class CreateDiagnosesVisits < ActiveRecord::Migration
  def change
    create_table :diagnoses_visits, id: false do |t|
      t.belongs_to :diagnosis, index: true
      t.belongs_to :visit, index: true
    end
  end
end

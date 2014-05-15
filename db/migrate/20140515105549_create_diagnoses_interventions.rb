class CreateDiagnosesInterventions < ActiveRecord::Migration
  def change
    create_table :diagnoses_interventions, id: false do |t|
      t.belongs_to :diagnosis
      t.belongs_to :intervention
    end
  end
end

class CreateDiagnosesIndicators < ActiveRecord::Migration
  def change
    create_table :diagnoses_indicators, id: false do |t|
      t.belongs_to :indicator
      t.belongs_to :diagnosis
    end
  end
end

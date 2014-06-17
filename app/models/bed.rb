class Bed < ActiveRecord::Base
  has_many :hospitalizations
  has_many :patients, through: :hospitalizations

  def current_patient
    self.patients.where('hospitalizations.datahora_saida is null')
  end
end

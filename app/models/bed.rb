class Bed < ActiveRecord::Base
  has_many :hospitalizations
  has_many :patients, through: :hospitalizations

  def current_patient
    self.patients.where('hospitalizations.checkout is null').first
  end

  def current_hospitalization
    self.hospitalizations.where('hospitalizations.checkout is null').first
  end

  def available?
    self.current_patient.nil?
  end
end

class HospitalizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hospitalization, only: [:show]

  def index
    @patient = Patient.find params[:patient_id]
    @hospitalizations = @patient.hospitalizations.order('checkin desc').page(params[:page])
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hospitalization
    @hospitalization = Hospitalization.find(params[:id])
  end

end

class VisitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_hospitalization, only: [:physical_examination, :indicators, :diagnoses, :interventions, :finish]

  def bed_history
    @bed = Bed.find(params[:bed_id])
    @visits = Visit.joins(:hospitalization).where('hospitalizations.bed_id = ?', @bed.id).order('datahora desc')
  end

  def patient_history
    @patient = Patient.find params[:patient_id]
    @visits = Visit.joins(:hospitalization).where('hospitalizations.patient_id = ?', @patient.id).order('datahora desc')
  end

  def details
    @visit = Visit.find params[:id]
  end

  def physical_examination

  end

  def indicators
    @main_categories = IndicatorCategory.main_categories
    @indicators_categories = IndicatorCategory.order('name asc')
  end

  def diagnoses
    indicators = params[:indicators]
    obs = params[:obs].select { |o| indicators.include? o } unless indicators.nil?
    session[:indicators] = indicators
    session[:indicators_obs] = obs
    @diagnoses = Diagnosis.joins(:indicators).where('indicators.id in (?)', indicators).uniq.order('diagnoses.name asc')
  end

  def interventions
    diagnoses = params[:diagnoses]
    session[:diagnoses] = diagnoses
    @interventions = Intervention.joins(:diagnoses).where('diagnoses.id in (?)', diagnoses).uniq.order('interventions.name asc')
  end

  def finish
    Visit.transaction do
      @visit = Visit.new
      @visit.datahora = Time.now
      @visit.hospitalization_id = @hospitalization.id
      @visit.user_id = current_user.id
      @visit.save

      @indicators = session[:indicators]
      obs = session[:indicators_obs]
      @indicators.each do |indicator|
        indicator_visit = IndicatorVisit.new
        indicator_visit.indicator_id = indicator.to_s
        indicator_visit.obs = obs[indicator.to_s]
        indicator_visit.visit_id = @visit.id
        indicator_visit.save
      end

      diagnoses_ids = session[:diagnoses]
      diagnoses_ids.each do |diagnosis_id|
        diagnosis = Diagnosis.find diagnosis_id
        @visit.diagnoses << diagnosis
      end

      interventions_ids = params[:interventions]
      interventions_ids.each do |intervention_id|
        intervention = Intervention.find intervention_id
        @visit.interventions << intervention
      end
    end
  end

  private
  def set_current_hospitalization
    @bed = Bed.find(params[:bed_id])
    @hospitalization = @bed.current_hospitalization
  end
end

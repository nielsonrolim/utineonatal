class VisitsController < ApplicationController
  before_action :authenticate_user!, except: [:details]
  before_action :set_current_hospitalization, only: [:physical_examination, :indicators, :diagnoses, :interventions, :finish]

  def bed_history
    @bed = Bed.find(params[:bed_id])
    @visits = Visit.joins(:hospitalization).where('hospitalizations.bed_id = ?', @bed.id).order('datahora desc')
  end

  def patient_history
    @patient = Patient.find params[:patient_id]
    @visits = Visit.joins(:hospitalization).where('hospitalizations.patient_id = ?', @patient.id).order('datahora desc').page(params[:page])
  end

  def details
    @visit = Visit.find params[:id]
    @first_visit = @visit.hospitalization.visits.order('datahora asc').first

    @visit.head_circumference = @first_visit.head_circumference if @visit.head_circumference.nil?
    @visit.thoracic_perimeter = @first_visit.thoracic_perimeter if @visit.thoracic_perimeter.nil?
    @visit.waist_circumference = @first_visit.waist_circumference if @visit.waist_circumference.nil?
    @visit.weight = @first_visit.weight if @visit.weight.nil?
    @visit.stature = @first_visit.stature if @visit.stature.nil?

    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf => "file_name.pdf",
                :show_as_html => params[:debug].present?
      end
    end
  end

  def new
    clear_visit
    redirect_to physical_examination_path(params[:bed_id])
  end

  def physical_examination
    @bed_id = params[:bed_id]
    if session[:visit_params].nil?
      @visit = Visit.new
    else
      @visit = Visit.new(session[:visit_params])
    end

  end

  def indicators
    unless session[:visit_params].nil?
      params[:visit] = session[:visit_params]
    end
    unless params[:visit].nil?
      @visit = Visit.new(visit_params)
    else
      @visit = Visit.new
    end

    if @visit.valid?
      if session[:visit_params].nil?
        session[:visit_params] = visit_params
      end
      if session[:indicators]
        @indicators_ids = session[:indicators].each_with_index { |e, i| session[:indicators][i] = e.to_i }
      else
        @indicators_ids = Array.new
      end

      @obs = session[:indicators_obs]
      @main_categories = IndicatorCategory.main_categories
    else
      render 'physical_examination'
    end
  end

  def diagnoses
    indicators = params[:indicators] || session[:indicators]

    indicators_radio = params[:indicators_radio]
    indicators_radio.each do |category_id, id|
      indicators.push id
    end

    if indicators.nil?
      flash[:error] = 'Por favor, selecione pelo menos um indicador.'
      redirect_to visit_indicators_path(@hospitalization.bed_id)
    end
    obs = params[:obs] || session[:indicators_obs]
    obs = obs.select { |o| indicators.include? o } unless indicators.nil?
    session[:indicators] = indicators
    session[:indicators_obs] = obs
    @diagnoses_ids = session[:diagnoses] || Array.new
    @diagnoses = Diagnosis.joins(:indicators).where('indicators.id in (?)', indicators).uniq.order('diagnoses.name asc')
  end

  def interventions
    diagnoses = params[:diagnoses] || session[:diagnoses]
    if diagnoses.nil?
      flash[:error] = 'Por favor, selecione pelo menos um diagnóstico.'
      redirect_to visit_diagnoses_get_path(@hospitalization.bed_id)
    end
    session[:diagnoses] = diagnoses
    @interventions = Intervention.joins(:diagnoses).where('diagnoses.id in (?)', diagnoses).uniq.order('interventions.name asc')
  end

  def finish
    interventions_ids = params[:interventions]
    if interventions_ids.nil?
      flash[:error] = 'Por favor, selecione pelo menos uma intervenção.'
      redirect_to visit_interventions_get_path(@hospitalization.bed_id)
    else
      Visit.transaction do
        @visit = Visit.new(session[:visit_params])
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

        interventions_ids.each do |intervention_id|
          intervention = Intervention.find intervention_id
          @visit.interventions << intervention
        end

      end
      clear_visit
      flash[:notice] = 'Visita finalizada com sucesso!'
      redirect_to visit_details_path(@visit.id)
    end
  end

  def cancel_visit
    clear_visit
    redirect_to beds_list_path
  end

  private
  def clear_visit
    session[:visit_params] = nil
    session[:indicators] = nil
    session[:indicators_obs] = nil
    session[:diagnoses] = nil
  end

  def set_current_hospitalization
    @bed = Bed.find(params[:bed_id])
    @hospitalization = @bed.current_hospitalization
  end

  def visit_params
    params.require(:visit).permit(:datahora, :hospitalization_id, :user_id, :head_circumference, :thoracic_perimeter, :waist_circumference, :weight, :stature, :incubator_temperature, :heart_rate, :respiratory_rate, :blood_pressure_min, :blood_pressure_max, :pulse, :temperature)
  end

end

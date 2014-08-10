class IndicatorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_indicator, only: [:show, :edit, :update, :destroy]

  # GET /indicators
  # GET /indicators.json
  def index
    @main_categories = IndicatorCategory.main_categories
    @indicators = Indicator.includes(:indicator_category).where('indicators.indicator_category_id is null').order('indicator_categories.name, indicators.name')
  end

  # GET /indicators/1
  # GET /indicators/1.json
  def show
  end

  # GET /indicators/new
  def new
    @indicator = Indicator.new
    @diagnoses = Diagnosis.order(:name)
    @main_categories = IndicatorCategory.main_categories
  end

  # GET /indicators/1/edit
  def edit
    @diagnoses = Diagnosis.order(:name)
    @main_categories = IndicatorCategory.main_categories
  end

  # POST /indicators
  # POST /indicators.json
  def create
    @indicator = Indicator.new(indicator_params)
    @diagnoses = Diagnosis.order(:name)
    @main_categories = IndicatorCategory.main_categories

    respond_to do |format|
      if @indicator.save
        @indicator.diagnoses = []
        selected_diagnoses = params[:selected_diagnoses]
        unless selected_diagnoses.nil?
          selected_diagnoses.each do |id|
            diagnosis = Diagnosis.find id
            @indicator.diagnoses << diagnosis
          end
        end
        format.html { redirect_to @indicator, notice: 'Indicador foi adicionado com sucesso.' }
        format.json { render :show, status: :created, location: @indicator }
      else
        format.html { render :new }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indicators/1
  # PATCH/PUT /indicators/1.json
  def update
    @diagnoses = Diagnosis.order(:name)
    @main_categories = IndicatorCategory.main_categories

    respond_to do |format|
      if @indicator.update(indicator_params)
        @indicator.diagnoses = []
        selected_diagnoses = params[:selected_diagnoses]
        unless selected_diagnoses.nil?
          selected_diagnoses.each do |id|
            diagnosis = Diagnosis.find id
            @indicator.diagnoses << diagnosis
          end
        end
        format.html { redirect_to @indicator, notice: 'Indicador foi apagado com sucesso.' }
        format.json { render :show, status: :ok, location: @indicator }
      else
        format.html { render :edit }
        format.json { render json: @indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indicators/1
  # DELETE /indicators/1.json
  def destroy
    @indicator.destroy
    respond_to do |format|
      format.html { redirect_to indicators_url, notice: 'Indicador foi apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_indicator
    @indicator = Indicator.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def indicator_params
    params.require(:indicator).permit(:name, :obs_description, :has_obs, :indicator_category_id)
  end
end

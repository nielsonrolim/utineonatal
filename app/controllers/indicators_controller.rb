class IndicatorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_indicator, only: [:show, :edit, :update, :destroy]

  # GET /indicators
  # GET /indicators.json
  def index
    #@indicators = Indicator.all
    @indicators = Indicator.includes(:indicator_category).order('indicator_categories.name, indicators.name')
  end

  # GET /indicators/1
  # GET /indicators/1.json
  def show
  end

  # GET /indicators/new
  def new
    @indicator = Indicator.new
    @diagnoses = Diagnosis.order(:name)
  end

  # GET /indicators/1/edit
  def edit
    @diagnoses = Diagnosis.order(:name)
  end

  # POST /indicators
  # POST /indicators.json
  def create
    @indicator = Indicator.new(indicator_params)

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
        format.html { redirect_to @indicator, notice: 'Indicator was successfully created.' }
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
        format.html { redirect_to @indicator, notice: 'Indicator was successfully updated.' }
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
      format.html { redirect_to indicators_url, notice: 'Indicator was successfully destroyed.' }
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

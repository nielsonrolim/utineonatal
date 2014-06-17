class DiagnosesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diagnosis, only: [:show, :edit, :update, :destroy]

  # GET /diagnoses
  # GET /diagnoses.json
  def index
    @diagnoses = Diagnosis.order(:name)
  end

  # GET /diagnoses/1
  # GET /diagnoses/1.json
  def show
  end

  # GET /diagnoses/new
  def new
    @diagnosis = Diagnosis.new
    @interventions = Intervention.order(:name)
  end

  # GET /diagnoses/1/edit
  def edit
    @interventions = Intervention.order(:name)
  end

  # POST /diagnoses
  # POST /diagnoses.json
  def create
    @diagnosis = Diagnosis.new(diagnosis_params)

    respond_to do |format|
      if @diagnosis.save
        @diagnosis.interventions = []
        selected_interventions = params[:selected_interventions]
        unless selected_interventions.nil?
          selected_interventions.each do |id|
            interventions = Intervention.find id
            @diagnosis.interventions << interventions
          end
        end
        format.html { redirect_to @diagnosis, notice: 'Diagnosis was successfully created.' }
        format.json { render :show, status: :created, location: @diagnosis }
      else
        format.html { render :new }
        format.json { render json: @diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagnoses/1
  # PATCH/PUT /diagnoses/1.json
  def update
    respond_to do |format|
      if @diagnosis.update(diagnosis_params)
        @diagnosis.interventions = []
        selected_interventions = params[:selected_interventions]
        unless selected_interventions.nil?
          selected_interventions.each do |id|
            interventions = Intervention.find id
            @diagnosis.interventions << interventions
          end
        end
        format.html { redirect_to @diagnosis, notice: 'Diagnosis was successfully updated.' }
        format.json { render :show, status: :ok, location: @diagnosis }
      else
        format.html { render :edit }
        format.json { render json: @diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnoses/1
  # DELETE /diagnoses/1.json
  def destroy
    @diagnosis.destroy
    respond_to do |format|
      format.html { redirect_to diagnoses_url, notice: 'Diagnosis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_diagnosis
    @diagnosis = Diagnosis.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def diagnosis_params
    params.require(:diagnosis).permit(:name)
  end
end

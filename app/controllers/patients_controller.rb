class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def search
    @bed_id = params[:bed_id]
    @search = params[:search]
    @patients = Patient.text_search(@search)
    if @bed_id
      render 'beds/new_hospitalization'
    else
      @patients = @patients.page(params[:page])
      render 'patients/index'
    end
  end

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.order(:name).page(params[:page])
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    @bed_id = params[:bed_id]
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    bed_id = params[:bed_id]

    respond_to do |format|
      if @patient.save
        format.html do
          if bed_id.nil?
            redirect_to patients_url, notice: 'Paciente criado com sucesso.'
          else
            redirect_to new_hospitalization_additional_path(bed_id, @patient.id)
          end
        end
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patients_url, notice: 'Paciente atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Paciente apago com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def patient_params
    params.require(:patient).permit(:name, :medical_record_number, :birthdate, :sex, :childbirth_type, :apgar_first_min, :apgar_fifth_min, :gestational_age, :blood_type)
  end
end

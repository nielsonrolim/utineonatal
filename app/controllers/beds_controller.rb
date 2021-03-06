class BedsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_bed, only: [:show, :edit, :update, :destroy]

  def list
    @beds = Bed.all
  end

  def vacate
    bed = Bed.find params[:bed_id]
    hospitalization = bed.current_hospitalization
    hospitalization.checkout = Time.now
    hospitalization.save

    redirect_to beds_list_url
  end

  def new_hospitalization
    @bed_id = params[:bed_id]
  end

  def new_hospitalization_additional
    @bed = Bed.find params[:bed_id]
    @patient = Patient.find params[:patient_id]

    @hospitalization = Hospitalization.where('patient_id = ? and checkout is null', @patient.id).first

    unless @hospitalization.nil?
      flash[:error] = "Paciente #{@patient.name} já está internado no Leito #{@hospitalization.bed.number}"
      redirect_to beds_list_url
    else
      @hospitalization = Hospitalization.new
    end
  end

  def create_hospitalization
    bed = Bed.find params[:bed_id]
    patient = Patient.find params[:patient_id]

    @hospitalization = Hospitalization.new(hospitalization_params)

    @hospitalization.bed = bed
    @hospitalization.patient = patient

    unless @hospitalization.save
      flash[:error] = "Erro ao salvar Internação"
    end

    redirect_to beds_list_url
  end

  # GET /beds
  # GET /beds.json
  def index
    @beds = Bed.all
  end

  # GET /beds/1
  # GET /beds/1.json
  def show
  end

  # GET /beds/new
  def new
    @bed = Bed.new
    @patients = Patient.order('name asc')
    @current_patient_id = nil
  end

  # GET /beds/1/edit
  def edit
    @patients = Patient.order('name asc')
    if @bed.current_patient.nil?
      @current_patient_id = nil
    else
      @current_patient_id = @bed.current_patient.id
    end
  end

  # POST /beds
  # POST /beds.json
  def create
    @bed = Bed.new(bed_params)
    patient_id = params[:patient_id]

    respond_to do |format|
      if @bed.save
        patient_id = params[:patient_id]

        unless patient_id.blank?
          patient = Patient.find patient_id

          if @bed.current_hospitalization.nil?
            hospitalization = Hospitalization.new
            hospitalization.patient = patient
            hospitalization.bed = @bed
            hospitalization.checkin = Time.now
            hospitalization.save
          else
            if @bed.current_patient.id != patient_id.to_i
              old_hospitalization = @bed.current_hospitalization
              old_hospitalization.checkout = Time.now
              old_hospitalization.save
              hospitalization = Hospitalization.new
              hospitalization.patient = patient
              hospitalization.bed = @bed
              hospitalization.checkin = Time.now
              hospitalization.save
            end
          end

        else
          unless @bed.current_hospitalization.nil?
            hospitalization = @bed.current_hospitalization
            hospitalization.checkout = Time.now
            hospitalization.save
          end
        end

        format.html { redirect_to @bed, notice: 'Bed was successfully created.' }
        format.json { render :show, status: :created, location: @bed }
      else
        format.html { render :new }
        format.json { render json: @bed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beds/1
  # PATCH/PUT /beds/1.json
  def update
    respond_to do |format|
      if @bed.update(bed_params)
        patient_id = params[:patient_id]

        unless patient_id.blank?
          patient = Patient.find patient_id

          if @bed.current_hospitalization.nil?
            hospitalization = Hospitalization.new
            hospitalization.patient = patient
            hospitalization.bed = @bed
            hospitalization.checkin = Time.now
            hospitalization.save
          else
            if @bed.current_patient.id != patient_id.to_i
              old_hospitalization = @bed.current_hospitalization
              old_hospitalization.checkout = Time.now
              old_hospitalization.save
              hospitalization = Hospitalization.new
              hospitalization.patient = patient
              hospitalization.bed = @bed
              hospitalization.checkin = Time.now
              hospitalization.save
            end
          end

        else
          unless @bed.current_hospitalization.nil?
            hospitalization = @bed.current_hospitalization
            hospitalization.checkout = Time.now
            hospitalization.save
          end
        end

        format.html { redirect_to @bed, notice: 'Bed was successfully updated.' }
        format.json { render :show, status: :ok, location: @bed }
      else
        format.html { render :edit }
        format.json { render json: @bed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beds/1
  # DELETE /beds/1.json
  def destroy
    @bed.destroy
    respond_to do |format|
      format.html { redirect_to beds_url, notice: 'Bed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_bed
    @bed = Bed.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bed_params
    params.require(:bed).permit(:number)
  end

  def hospitalization_params
    params.require(:hospitalization).permit(:checkin, :checkout, :patient_id, :bed_id, :origin, :transport_conditions, :obs, :reason)
  end
end

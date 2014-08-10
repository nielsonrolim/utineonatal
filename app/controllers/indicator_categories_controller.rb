class IndicatorCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_indicator_category, only: [:show, :edit, :update, :destroy]

  # GET /indicator_categories
  # GET /indicator_categories.json
  def index
    @indicator_categories = IndicatorCategory.main_categories
  end

  # GET /indicator_categories/1
  # GET /indicator_categories/1.json
  def show
  end

  # GET /indicator_categories/new
  def new
    @indicator_category = IndicatorCategory.new
  end

  # GET /indicator_categories/1/edit
  def edit
  end

  # POST /indicator_categories
  # POST /indicator_categories.json
  def create
    @indicator_category = IndicatorCategory.new(indicator_category_params)

    respond_to do |format|
      if @indicator_category.save
        format.html { redirect_to @indicator_category, notice: 'Categoria do Indicador foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @indicator_category }
      else
        format.html { render :new }
        format.json { render json: @indicator_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indicator_categories/1
  # PATCH/PUT /indicator_categories/1.json
  def update
    respond_to do |format|
      if @indicator_category.update(indicator_category_params)
        format.html { redirect_to @indicator_category, notice: 'Categoria do Indicador foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @indicator_category }
      else
        format.html { render :edit }
        format.json { render json: @indicator_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indicator_categories/1
  # DELETE /indicator_categories/1.json
  def destroy
    @indicator_category.destroy
    respond_to do |format|
      format.html { redirect_to indicator_categories_url, notice: 'Categoria do Indicador foi apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_indicator_category
    @indicator_category = IndicatorCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def indicator_category_params
    params.require(:indicator_category).permit(:name, :parent_id)
  end
end

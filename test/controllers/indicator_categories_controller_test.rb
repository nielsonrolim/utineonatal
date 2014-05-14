require 'test_helper'

class IndicatorCategoriesControllerTest < ActionController::TestCase
  setup do
    @indicator_category = indicator_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:indicator_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create indicator_category" do
    assert_difference('IndicatorCategory.count') do
      post :create, indicator_category: { name: @indicator_category.name }
    end

    assert_redirected_to indicator_category_path(assigns(:indicator_category))
  end

  test "should show indicator_category" do
    get :show, id: @indicator_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @indicator_category
    assert_response :success
  end

  test "should update indicator_category" do
    patch :update, id: @indicator_category, indicator_category: { name: @indicator_category.name }
    assert_redirected_to indicator_category_path(assigns(:indicator_category))
  end

  test "should destroy indicator_category" do
    assert_difference('IndicatorCategory.count', -1) do
      delete :destroy, id: @indicator_category
    end

    assert_redirected_to indicator_categories_path
  end
end

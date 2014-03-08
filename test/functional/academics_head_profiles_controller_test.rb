require 'test_helper'

class AcademicsHeadProfilesControllerTest < ActionController::TestCase
  setup do
    @academics_head_profile = academics_head_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:academics_head_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create academics_head_profile" do
    assert_difference('AcademicsHeadProfile.count') do
      post :create, academics_head_profile: {  }
    end

    assert_redirected_to academics_head_profile_path(assigns(:academics_head_profile))
  end

  test "should show academics_head_profile" do
    get :show, id: @academics_head_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @academics_head_profile
    assert_response :success
  end

  test "should update academics_head_profile" do
    put :update, id: @academics_head_profile, academics_head_profile: {  }
    assert_redirected_to academics_head_profile_path(assigns(:academics_head_profile))
  end

  test "should destroy academics_head_profile" do
    assert_difference('AcademicsHeadProfile.count', -1) do
      delete :destroy, id: @academics_head_profile
    end

    assert_redirected_to academics_head_profiles_path
  end
end

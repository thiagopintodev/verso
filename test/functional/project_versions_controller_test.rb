require 'test_helper'

class ProjectVersionsControllerTest < ActionController::TestCase
=begin
  setup do
    @project_version = project_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_version" do
    assert_difference('ProjectVersion.count') do
      post :create, project_version: @project_version.attributes
    end

    assert_redirected_to project_version_path(assigns(:project_version))
  end

  test "should show project_version" do
    get :show, id: @project_version.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_version.to_param
    assert_response :success
  end

  test "should update project_version" do
    put :update, id: @project_version.to_param, project_version: @project_version.attributes
    assert_redirected_to project_version_path(assigns(:project_version))
  end

  test "should destroy project_version" do
    assert_difference('ProjectVersion.count', -1) do
      delete :destroy, id: @project_version.to_param
    end

    assert_redirected_to project_versions_path
  end
=end
end

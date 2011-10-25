require 'test_helper'

class DegreesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Degree.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Degree.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Degree.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to degree_url(assigns(:degree))
  end

  def test_edit
    get :edit, :id => Degree.first
    assert_template 'edit'
  end

  def test_update_invalid
    Degree.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Degree.first
    assert_template 'edit'
  end

  def test_update_valid
    Degree.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Degree.first
    assert_redirected_to degree_url(assigns(:degree))
  end

  def test_destroy
    degree = Degree.first
    delete :destroy, :id => degree
    assert_redirected_to degrees_url
    assert !Degree.exists?(degree.id)
  end
end

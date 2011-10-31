require 'test_helper'

class AnimationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Animation.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Animation.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Animation.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to animation_url(assigns(:animation))
  end

  def test_edit
    get :edit, :id => Animation.first
    assert_template 'edit'
  end

  def test_update_invalid
    Animation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Animation.first
    assert_template 'edit'
  end

  def test_update_valid
    Animation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Animation.first
    assert_redirected_to animation_url(assigns(:animation))
  end

  def test_destroy
    animation = Animation.first
    delete :destroy, :id => animation
    assert_redirected_to animations_url
    assert !Animation.exists?(animation.id)
  end
end

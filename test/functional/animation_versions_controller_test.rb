require 'test_helper'

class AnimationVersionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    AnimationVersion.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    AnimationVersion.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to animation_versions_url
  end

  def test_index
    get :index
    assert_template 'index'
  end
end

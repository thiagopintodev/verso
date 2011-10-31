require 'test_helper'

class AnimationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Animation.new.valid?
  end
end

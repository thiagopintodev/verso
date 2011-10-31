require 'test_helper'

class AnimationVersionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AnimationVersion.new.valid?
  end
end

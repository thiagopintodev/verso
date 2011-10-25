require 'test_helper'

class DegreeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Degree.new.valid?
  end
end

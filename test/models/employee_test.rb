require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  
  # Relationship matchers...
  should have_many(:assignments)
  should have_many(:stores).through(:assignments)

  
end

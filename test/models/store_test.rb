require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  
  # Relationship matchers...
  should have_many(:employees).through(:assignments)
  should have_many(:assignments)

  
end

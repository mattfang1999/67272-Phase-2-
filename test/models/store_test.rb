require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  
  # Relationship matchers...
  should have_many(:employees).through(:assignments)
  should have_many(:assignments)

  should belong_to(:animal)
  should belong_to(:medicine)
  should have_one(:pet).through(:visit)
  should have_many(:visits)
  should have_many(:dosages).through(:visits)
  should have_many(:treatments).through(:visits)
end

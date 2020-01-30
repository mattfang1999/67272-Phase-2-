require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  
  # Relationship matchers...
  should have_many(:employees).through(:assignments)
  should have_many(:assignments)

  context "Creating stores context" do
  	# create the stores I want witih factories
  	setup do
  		create_stores
	end

	# and provide a teardown method as well
	teardown do
		destroy_stores
	end



	# now run the tests:
	# test the scope alphabetical'
	should "show that stores are listed in alphabetical order" do
		assert_equal ["Panda Supermarket", "Target", "Trader Joes", "Walmart"], Store.alphabetical.map{|s| s.name}
	end 

  	
  	
  #   # now run the tests:
  #   # test the scope 'alphabetical'
  #   should "shows that animals are listed in alphabetical order" do
  #     assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit", "Turtle"], Animal.alphabetical.map{|a| a.name}
  #   end
    
  #   # test the scope 'active'
  #   should "shows that there are five active animals" do
  #     assert_equal 5, Animal.active.size
  #     # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
  #     assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit"], Animal.active.map{|a| a.name}.sort
  #   end

  #   # test the scope 'inactive'
  #   should "shows that there is one inactive animal" do
  #     assert_equal 1, Animal.inactive.size
  #     # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
  #     assert_equal ["Turtle"], Animal.inactive.map{|a| a.name}.sort
  #   end
  # end

  end
end

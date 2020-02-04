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

	#test the scope 'active'
	should 'shows that there are active stores' do
		#first show that there are 3 active stores
		assert_equal 3, Store.active.size 
		#make a store inactive and then test there are 2 active stores 
		@panda.active = false
		@panda.save 
		assert_equal 2, Store.active.size 
		assert_equal ['Target', 'Trader Joes'], Store.active.alphabetical.map{|s| s.name}.sort
	end
	
	#test the scope 'inactive'
	should 'shows that there are inactive stores' do 
		# #first show that there is 3 active stores
		# assert_equal 3, Store.active.size 
		# #make two stores inactive and then test there are 1 active stores 
		# @panda.active = false 
		# @panda.save
		# @trader.active = false
		# @trader.save
		# assert_equal 1, Store.active.size
		# assert_equal ['Target'], Store.active.alphabetical.map{|s| s.name}.sort

		assert_equal 1, Store.inactive.size 
		@panda.active = false
		@panda.save 
		assert_equal 2, Store.inactive.size 
		assert_equal ['Panda Supermarket', 'Walmart'], Store.inactive.map{|s| s.name}.sort 
	end 


	# # test the scope 'active'
 #    should "have a scope for active medicines" do
 #      # make a medicine inactive first...
 #      @amoxicillin.active = false
 #      @amoxicillin.save
 #      assert_equal ["Carprofen", "Rabies"], Medicine.active.map{|o| o.name}.sort
 #    end
  	
  	
 #  #   # now run the tests:
 #  #   # test the scope 'alphabetical'
 #  #   should "shows that animals are listed in alphabetical order" do
 #  #     assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit", "Turtle"], Animal.alphabetical.map{|a| a.name}
 #  #   end
    
	#     # test the scope 'active'
	#     should "shows that there are five active animals" do
	#       assert_equal 5, Animal.active.size
	#       assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
	#       assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit"], Animal.active.map{|a| a.name}.sort
	#     end

 #    # test the scope 'inactive'
 #    should "shows that there is one inactive animal" do
 #      assert_equal 1, Animal.inactive.size
 #      assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
 #      assert_equal ["Turtle"], Animal.inactive.map{|a| a.name}.sort
 #    end
 #  end

  end
end

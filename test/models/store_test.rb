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
		assert_equal ['Target', 'Trader Joes'], Store.active.map{|s| s.name}.sort
		#make all stores inactive and show there are no active stores
		@target.active = false
		@target.save 
		@trader.active = false 
		@trader.save 
		assert_equal [], Store.active.map{|s| s.name}.sort
		
	end

		
		#test the scope 'inactive'
		should 'shows that there are inactive stores' do 
			#First show there is one inactive store 
			assert_equal 1, Store.inactive.size 
			assert_equal ['Walmart'], Store.inactive.map{|s| s.name}.sort 
			#Next Show there are no inactive stores
			@walmart.active = true
			@walmart.save 
			assert_equal 0, Store.inactive.size 
			assert_equal [], Store.inactive.map{|s| s.name}.sort 
			#Next make two of the stores inactive  
			@panda.active = false
			@panda.save
			@walmart.active = false 
			@walmart.save 
			assert_equal 2, Store.inactive.size 
			assert_equal ['Panda Supermarket', 'Walmart'], Store.inactive.map{|s| s.name}.sort 
		end 


  end
end

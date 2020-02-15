require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  
  # Relationship matchers...
  should have_many(:employees).through(:assignments)
  should have_many(:assignments)

  #Validation Testing

	# Validation macros...
  	should validate_presence_of(:name)
  	should validate_presence_of(:street)
  	should validate_presence_of(:city)

  	# Validating phone...
  	should allow_value("4122683259").for(:phone)
  	should allow_value("412-268-3259").for(:phone)
  	
  	should_not allow_value("(412) 268-3259").for(:phone)
  	should_not allow_value("412.268.3259").for(:phone)
  	should_not allow_value("2683259").for(:phone)
  	should_not allow_value("4122683259x224").for(:phone)
  	should_not allow_value("800-EAT-FOOD").for(:phone)
  	should_not allow_value("412/268/3259").for(:phone)
  	should_not allow_value("412-2683-259").for(:phone)

  	# Validating zip...
	should allow_value("12234").for(:zip)
	should allow_value("23456").for(:zip)
	should allow_value("00000").for(:zip)
	  
	should_not allow_value("fred").for(:zip)
	should_not allow_value("3431").for(:zip)
	should_not allow_value("15213-9843").for(:zip)
	should_not allow_value("15d32").for(:zip)

	 #validating name uniqueness

	# # Validating state...
  	should allow_value("PA").for(:state)
  	should allow_value("WV").for(:state)
  	should allow_value("OH").for(:state)
  	should_not allow_value("bad").for(:state)
  	should_not allow_value(10).for(:state)
  	should_not allow_value("CA").for(:state)
  	should_not allow_value("Pennsylvania").for(:state)


  context "Creating stores context" do
  	# create the stores I want witih factories
  	setup do
  		create_stores
	end

	# and provide a teardown method as well
	teardown do
		destroy_stores
	end


	# should "validate name uniqueness" do

	# 	@target.name = 'Panda Supermarket'
	# 	should validate_uniqueness_of(:name)

	# end
	


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
		
		
	end

		
		#test the scope 'inactive'
		should 'shows that there are two inactive stores' do 
			#First show there is one inactive store 
			assert_equal 1, Store.inactive.size 
			assert_equal ['Walmart'], Store.inactive.map{|s| s.name}.sort 
			#Next Show there are 2 inactive stores
			@panda.active = false 
			@panda.save 
			assert_equal 2, Store.inactive.size 
			assert_equal ['Panda Supermarket', 'Walmart'], Store.inactive.map{|s| s.name}.sort 
			 
		end


	

	


  end
end

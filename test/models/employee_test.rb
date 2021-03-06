require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  
  # Relationship matchers...
  should have_many(:assignments)
  should have_many(:stores).through(:assignments)

  #Validation Testing


	# Validation macros...
  	should validate_presence_of(:first_name)
  	should validate_presence_of(:last_name)
  	should validate_presence_of(:role)
  	should validate_presence_of(:ssn)

  	# Validating phone...
  	should allow_value("4122683259").for(:phone)
  	should allow_value("412-268-3259").for(:phone)
  	should allow_value("(412) 268-3259").for(:phone) #Why does this pass? 
  	
  	
  	should_not allow_value("412.268.3259").for(:phone)
  	should_not allow_value("2683259").for(:phone)
  	should_not allow_value("4122683259x224").for(:phone)
  	should_not allow_value("800-EAT-FOOD").for(:phone)
  	should_not allow_value("412/268/3259").for(:phone)
  	should_not allow_value("412-2683-259").for(:phone)

  	# Validating SSN 
  	should allow_value("123456789").for(:ssn)
  	should allow_value("123-45-6789").for(:ssn)
  	should allow_value("(123) 45-6789").for(:ssn)

  	should_not allow_value("123.45.6789").for(:phone)
  	should_not allow_value("123456").for(:phone)
  	should_not allow_value("4122683259x224").for(:phone)
  	should_not allow_value("800-EAT-FOOD").for(:phone)
  	should_not allow_value("123/45/6789").for(:phone)
  	should_not allow_value("123-4567-890").for(:phone)

  	#Validating dob 
  	should allow_value("1999-07-14").for(:date_of_birth)
  	should allow_value(Date.today.to_date).for(:date_of_birth)

  	should_not allow_value(1.day.from_now.to_date).for(:date_of_birth) #Why doees this pass? 




	
	context "Creating employees context" do
		#create the employees I want with factories
		setup do
			create_stores
			create_employees
			create_assignments
		end 

		#and provide a teardown method as well
	teardown do
			destroy_assignments
			destroy_employees
			destroy_stores
		end

		# now run the tests:

		# test the scope alphabetical'
		should "show that the employees are listed in alphabetical order by last and first name" do
			#Boy, Young
			#Fang, Evan
			#Fang, Matthew
			#Zhang, Chen
			assert_equal ['Boy', 'Fang', 'Fang', 'Zhang'], Employee.alphabetical.map{|e| e.last_name}
			assert_equal ['Young', 'Evan', 'Matthew', 'Chen'], Employee.alphabetical.map{|e| e.first_name}
		end


		#test the scope active 
		should 'shows that there are two active employees' do
		#first show that there are two active employees 
			assert_equal 3, Employee.active.size
			assert_equal ['Chen','Matthew','Young'], Employee.active.map{|e| e.first_name}.sort
			
		#make one employee inactive to have 2 active employees 
			@young.active = false
			@young.save 
			assert_equal 2, Employee.active.size 
			assert_equal ['Chen', 'Matthew'], Employee.active.map{|e| e.first_name}.sort 
		end 

		# #test the scope inactive 
		should 'shows that there are two inactive employees' do
		#first show there is one inactive employee
			assert_equal 1, Employee.inactive.size
			assert_equal ['Evan'], Employee.inactive.map{|e| e.first_name}.sort
		#make another employee inactive  
		@young.active = false  
		@young.save
		assert_equal 2, Employee.inactive.size 
		assert_equal ['Evan', 'Young'], Employee.inactive.map{|e| e.first_name}.sort 

		end

		#test the scope regulars
		should 'show that there are three employees' do
			assert_not_equal 'employee', @matthew.role
			assert_equal 'employee', @evan.role
			assert_equal ['Evan', 'Young'], Employee.regulars.map{|e| e.first_name}.sort
			#add a new employee 
			@employee_boy = FactoryBot.build(:employee, first_name: 'Employee Boy', role: 'employee' )
			@employee_boy.save
			assert_equal 'employee', @employee_boy.role
			assert_equal ['Employee Boy', 'Evan', 'Young'], Employee.regulars.map{|e| e.first_name}.sort

			
		end 

		#test the scope managers
		should 'show that there are two managers' do
			assert_not_equal 'manager', @matthew.role
			assert_equal 'manager', @chen.role
			assert_equal ['Chen'], Employee.managers.map{|e| e.first_name}.sort
			#change evan's role to manager 
			@evan.role = 'manager'
			@evan.save 
			assert_equal 'manager', @evan.role
			assert_equal ['Chen', 'Evan'], Employee.managers.map{|e| e.first_name}.sort
		end

		#test the scope admins
		should 'show that there are two admins' do 
			assert_not_equal 'admin', @chen.role
			assert_equal 'admin', @matthew.role
			#assert Matthew is the only admin 
			assert_equal ['Matthew'], Employee.admins.map{|e| e.first_name}.sort
			#change evan's role to admin
			@evan.role = 'admin'
			@evan.save
			assert_equal 'admin', @evan.role
			assert_equal ['Evan','Matthew'], Employee.admins.map{|e| e.first_name}.sort


		end

		#test the scope younger_than_18
		should 'show that only one employee is younger than 18 years' do
			#Young Boy is the only employee under 18 
			assert_equal ['Young'], Employee.younger_than_18.map{|e| e.first_name}.sort
			#Build a temporary exact 18 year old and ensure he is not under 18 
			@eighteen = FactoryBot.build(:employee, first_name: 'Eighteen Boy', date_of_birth: 18.years.ago.to_date)
			@eighteen.save
			puts(@eighteen.date_of_birth)
			assert_equal ['Young'], Employee.younger_than_18.map{|e| e.first_name}.sort
		end 

		#test the scope is_18_or_older
		should 'show that there are four people who are 18 or older' do
			assert_equal ['Chen', 'Evan', 'Matthew'], Employee.is_18_or_older.map{|e| e.first_name}.sort
			#Build a temporary exact 18 year old and ensure he is 18
			@eighteen = FactoryBot.build(:employee, first_name: 'Eighteen Boy', date_of_birth: 18.years.ago.to_date)
			@eighteen.save
			assert_equal ['Chen', 'Eighteen Boy', 'Evan', 'Matthew'], Employee.is_18_or_older.map{|e| e.first_name}.sort
			
		end

		# should 'show that there are three people who are only older than 18' do
		# 	assert_equal ['Chen', 'Evan', 'Matthew'], Employee.only_older_than_18.map{|e| e.first_name}.sort
		# 	#Build a temporary exact 18 year old and ensure he is 18
		# 	@eighteen = FactoryBot.build(:employee, first_name: 'Eighteen Boy', date_of_birth: 18.years.ago.to_date)
		# 	@eighteen.save
		# 	assert_equal ['Chen', 'Evan', 'Matthew'], Employee.only_older_than_18.map{|e| e.first_name}.sort
			
		# end


		
		#METHOD TESTS#
		#-----------------------------------------------
		# test the method 'name' works
    	should "shows that name method works" do
    		puts(@matthew.name)
     		assert_equal "Fang, Matthew", @matthew.name
      	end 

      	# test the method proper_name
      	#'proper_name' -- which returns the employee name as a string "first_name last_name" in that order
      	should "shows that proper_name works" do
      		puts(@matthew.proper_name)
      		assert_equal 'Matthew Fang', @matthew.proper_name
      	end

      	#test 'over_18?' -- which returns a boolean indicating whether this employee is over 18 or not
      	should 'show that employee is over 18' do
      		
      		assert_equal true, @matthew.over_18?
      		assert_equal false, @young.over_18?
      		@eighteen = FactoryBot.build(:employee, first_name: 'Eighteen Boy', date_of_birth: 18.years.ago.to_date)
			@eighteen.save
			assert_equal true, @eighteen.over_18?
			
      	end

      	#test 'age' --which returns the age of the employee
      	should 'show the age of an employee' do 
      		assert_equal 20, @matthew.age
      		assert_equal 16, @young.age

      		@new_guy= FactoryBot.build(:employee, first_name: 'New Guy', date_of_birth: '2005-02-25')
      		@new_guy.save
      		assert_equal 14, @new_guy.age

      		@new_guy_2= FactoryBot.build(:employee, first_name: 'New Guy 2', date_of_birth: '2005-01-14')
      		@new_guy_2.save
      		assert_equal 15, @new_guy_2.age

      		@new_guy_3=FactoryBot.build(:employee, first_name: 'New Guy 3', date_of_birth: '2005-02-11')
      		@new_guy_3.save
      		assert_equal 15, @new_guy_2.age



  
      		@baby = FactoryBot.build(:employee, first_name: 'Baby Boy', date_of_birth: Date.current.to_date)

      		@baby.save
      		assert_equal 0, @baby.age

      		@eighteen = FactoryBot.build(:employee, first_name: 'Eighteen Boy', date_of_birth: 18.years.ago)
			@eighteen.save
      		assert_equal 18, @eighteen.age 
      		#Test 0 year olds? 
      		#Test invalid ages 
      	end


      	#test the method current_assignment
      	# 'current_assignment' -- which returns the employee's current assignment or nil if the employee does not have a current assignment
      	should 'show that the current assignment works' do
      		# create_stores
      		# create_assignments
      		assert_equal [@matt_assign_2], @matthew.current_assignment
      		assert_equal [@chen_assign_1], @chen.current_assignment
      		#make a man with no assignment
      		@no_assign_man = FactoryBot.build(:employee, first_name: 'Ghost')
      		@no_assign_man.save
      		assert_nil @no_assign_man.current_assignment
      		# destroy_assignments
      		# destroy_stores
      		
      	end

    #   	should "have a method to find the current cost of medicine" do
    #   create_medicine_costs
    #   assert_equal 50, @carprofen.current_cost_per_unit
    #   assert_equal 30, @rabies.current_cost_per_unit
    #   destroy_medicine_costs
    #   # test the nil case by creating a new medicine without a cost
    #   @ghost_med   = FactoryBot.create(:medicine, name: 'Ghost Medicine')
    #   assert_nil @ghost_med.current_cost_per_unit
    # end


	end
  
end

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  
  # Relationship matchers...
  should have_many(:assignments)
  should have_many(:stores).through(:assignments)

	
	context "Creating employees context" do
		#create the employees I want with factories
		setup do
			create_employees
		end 

		#and provide a teardown method as well
	teardown do
			destroy_employees
		end

		# now run the tests:

		# test the scope alphabetical'
		should "show that the employees are listed in alphabetical order by last and first name" do
			assert_equal ['Fang', 'Fang', 'Zhang'], Employee.alphabetical.map{|e| e.last_name}
			assert_equal ['Evan', 'Matthew', 'Chen'], Employee.alphabetical.map{|e| e.first_name}
		end


		#test the scope active 
		should 'shows that there are active employees' do
		#first show that there are two active employees 
		assert_equal 2, Employee.active.size 
		#make an employee inactive and then test there is one active emplooyee
		@matthew.active = false 
		@matthew.save
		assert_equal 1, Employee.active.size 
		assert_equal ['Chen'], Employee.active.active.map{|e| e.first_name}.sort 
		end 

		#test the scope inactive 
		should 'shows that there are inactive employees' do
		#first show there is 2 active employees
		assert_equal 2, Employee.active.size 
		#make all employees active and then test there aree three active employees
		@evan.active = true 
		@evan.save
		assert_equal 3, Employee.active.size 
		assert_equal ['Evan', 'Matthew', 'Chen'], Employee.inactive.map{|e| e.first_name}

		end

		#test the scope regulars
		should 'show that an employee has the role employee' do
			assert_not_equal 'employee', @matthew.role
			assert_equal 'employee', @evan.role
			#add a new employee 
			@joe = Employee.new
			@joe.role = 'employee'
			@joe.save 
			assert_equal 'employee', @joe.role
			#assert_equal 2, Employee.role.size
		end 

		#test the scope managers
		should 'show that an employee has the role manager' do
			assert_not_equal 'manager', @matthew.role
			assert_equal 'manager', @chen.role 
			#change evan's role to manager 
			@evan.role = 'manager'
			@evan.save 
			assert_equal 'manager', @evan.role
		end

		#test the scope admins
		should 'show that an employee has the role admin' do 
			assert_not_equal 'admin', @chen.role
			assert_equal 'admin', @matthew.role
			#change evan's role to manager
			@evan.role = 'admin'
			@evan.save
			assert_equal 'admin', @evan.role
		end

		#test the scope younger_than_18
		should 'show that an employee is younger than 18 years' do 
			assert_equal ['Chen', 'Evan', 'Matthew'], Employee.younger_than_18.map{|o| o.name}
		end 
		


	end
  
end

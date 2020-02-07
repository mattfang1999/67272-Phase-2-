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
		


	end
  
end

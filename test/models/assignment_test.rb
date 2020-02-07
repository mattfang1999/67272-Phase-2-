require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  # Relationship matchers...

  should belong_to(:employee)
  should belong_to(:store)

  context "Creating assignments context" do
		#create the employees I want with factories
		setup do
			create_stores
			create_employees
			create_assignments
		end 

		#and provide a teardown method as well
	teardown do
			destroy_stores
			destroy_employees
			destroy_assignments
		end

  
end

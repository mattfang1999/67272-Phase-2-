require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  # Relationship matchers...

  should belong_to(:employee)
  should belong_to(:store)


  #Validation Testing

  #Testing Start Dates having no date in future

  should allow_value("1999-07-14").for(:start_date)
  should allow_value(Date.today.to_date).for(:start_date)
  should allow_value(1.day.ago.to_date).for(:start_date)

  should_not allow_value("bad").for(:start_date)
  should_not allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)

  should allow_value(nil).for(:end_date)
  
  #should allow_value(Date.today.to_date).for(:end_date)
  #should allow_value(10.days.from_now).for(:end_date)
 

 
  #How to make sure end dates don't start before start_dates? 

  context "Creating assignments context" do
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

    # should 'assert end dates are not before start_date' do


    # end

  should 'assert end dates are not before start dates' do 
      @new_assign = FactoryBot.build(:assignment, store_id: 4, employee_id: 1, start_date: 1.months.ago.to_date)
      @new_assign.save
      assert_equal true, @new_assign.valid?
      @new_assign.end_date = 2.months.ago.to_date
      @new_assign.save
      assert_equal false, @new_assign.valid?
      @new_assign.destroy
      # #assert_raises {FactoryBot.create(:assignment, store_id: 4, employee_id: 1, start_date: 1.months.ago.to_date, end_date: 2.months.ago.to_date)}
      # assert not(@new_assign.valid?) 
  end



# should 'assert end dates are not before start dates' do 

#       @new_assign = FactoryBot.create(:assignment, store_id: 4, employee_id: 1, start_date: 1.months.ago.to_date, end_date: 2.months.ago.to_date)
#       assert_equal false, @new_assign.valid?
#       #assert_raises {FactoryBot.create(:assignment, store_id: 4, employee_id: 1, start_date: 1.months.ago.to_date, end_date: 2.months.ago.to_date)}
#       assert not(@new_assign.valid?) 
#   end

  # should 'assert there is an invalid assignment' do
  #     @new_assign = FactoryBot.build(:assignment, store_id: 1, employee_id: 4, start_date: 1.months.ago.to_date, end_date: 0.months.ago.to_date)
  #     @new_assign.save
  #     assert_equal true, @new_assign.valid?
  #     @new_assign.store_id = 5
  #     @new_assign.save
  #     assert_equal false, @new_assign.valid?
  # end 


	# now run the tests:

	# test the scope current' -- which returns all the assignments that are considered current
	# how to test if an assignment is current? 
	should 'show that there are 3 assignments that are considered current' do
		assert_equal 3, Assignment.current.size 
		assert_equal ['Chen', 'Matthew', 'Young'], Assignment.current.map{|a| a.employee.first_name}.sort 

	end	

	# # test the scope 'past' -- which returns all the assignments that have terminated

	should 'show that there are 2 assignments that have terminated' do 
		assert_equal 2, Assignment.past.size 
		assert_equal ['Matthew', 'Young'], Assignment.past.map{|a| a.employee.first_name}.sort 
	
	end 

	#  #test the scope 'chronological' -- which orders assignments chronologically with the most recent assignments listed first
	#  #is there a better way to test for this? 
	 should "have all the assignments listed in desc order" do 
	 	assert_equal 5, Assignment.chronological.size
	 	assert_equal [@chen_assign_1, @young_assign_2, @young_assign_1, @matt_assign_2, @matt_assign_1], Assignment.chronological.to_a

	 	#get array of assignment dates in order
	 	tst = Array.new
	 	[1,9,9,12].sort.each {|n| tst << n.months.ago.to_date}
	 	tst.insert(0, Date.current.to_date)
	 	
	 	assert_equal tst, Assignment.chronological.map{|a| a.start_date}

	 	
	 end 

	#  # test the scope 'for_store' 
	#  #-- which returns all assignments that are associated with a given store (parameter: store object)
	 should "have a scope for_store" do
      assert_equal [@matt_assign_1, @young_assign_1], Assignment.for_store(@panda)
      assert_equal [@matt_assign_2, @chen_assign_1], Assignment.for_store(@target)
    end 

 #    # test the scope for_employee'
 #    #which returns all assignments that are associated with a given employee (parameter: employee object)
 #    #is an employee associated with an assignmeent if the assignment is no longer active? 
     should "have a scope for_employee" do 	
     	assert_equal [@matt_assign_1, @matt_assign_2], Assignment.for_employee(@matthew)
     	assert_equal [@chen_assign_1], Assignment.for_employee(@chen)
     end 
 #    #  # test the scope 'for_animal'
 #    # should "have a scope for_animal" do
 #    #   assert_equal [@dog_carprofen, @dog_rabies], AnimalMedicine.for_animal(@dog).sort_by{|o| o.medicine.name}
 #    # end

 #    #assert_equal [@dog_carprofen], AnimalMedicine.for_medicine(@carprofen)

 #     #test the scope for_role
 #     #'for_role' -- which returns all assignments that are associated with employees of a given role (parameter: role)
     should 'have a scope for_role' do 
     	assert_equal [@young_assign_1, @young_assign_2], Assignment.for_role('employee')
  		assert_equal [@chen_assign_1], Assignment.for_role('manager')
      #Change Chen into an employee. 
      @chen.role = 'employee'
      @chen.save
      assert_equal [@young_assign_1, @young_assign_2, @chen_assign_1], Assignment.for_role('employee')
      assert_equal [], Assignment.for_role('manager')


     end

     #test the scope by_store
     #'by_store' -- which orders assignments by store
     should 'order assignments by store ' do
     	assert_equal [@matt_assign_1, @young_assign_1, @matt_assign_2, @chen_assign_1, @young_assign_2], Assignment.by_store
     	assert_equal @young_assign_2, Assignment.by_store.last
     	
     end 

     #test the scope by_employee
     #'by_employee' -- which orders assignments by employee name(last, first)
     should 'order assignments by employee name (last, first)' do
     	assert_equal [@young_assign_1, @young_assign_2, @matt_assign_1, @matt_assign_2, @chen_assign_1], Assignment.by_employee
     	assert_equal @young_assign_1, Assignment.by_employee.first

 	  end 

    should 'make sure assignments cannot be created with an inactive employee or store' do
        #inactive employee should fail
        @fail_assign_1 = FactoryBot.create(:assignment, employee_id: 4, store_id: 2)
        @fail_assign_1.save
        @fail_assign_1.destroy
        #inactive store should fail 
        @fail_assign_2 = FactoryBot.create(:assignment, employee_id: 3, store_id: 3)
        @fail_assign_2.save
        @fail_assign_2.destroy
        #active employee should pass 
        # @fail_assign_3 = FactoryBot.create(:assignment, employee_id: 3, store_id: 30000)
        # @fail_assign_3.save
        # @fail_assign_3.destroy
    end 

 # 	 # should 'return all active assignments associated with a given employee' do 
 # 	 # 	assert_equal [@assign_6], Assignment.for_emp_assign(@chen).sort
 # 	 # 	assert_equal [@assign_1, @assign_2], Assignment.for_emp_assign(@matthew).sort
 # 	 # 	#assert_equal ['Matthew', 'Matthew'], Assignment.for_emp_assign(@matthew).map{|a| a.employee.first_name}
 # 	 # end 

    
 # #   #be used as a part of a callback when creating a new assignment. (callbacks will be explained later in class). Essentially this method and callback will update any previously open assignment (if applicable) an terminate it by automatically by setting the end date of the old assignment to the start date of the new assignment.
 	 should 'end previous assignment' do 
      @new_assign = FactoryBot.create(:assignment, store_id: 4, employee_id: 1, start_date: 1.months.ago.to_date)
      @new_assign.save!
      @matt_assign_2.reload

      
      assert_equal 1.months.ago.to_date, @matt_assign_2.end_date
      assert @matt_assign_2.end_date != nil
    end 



     
      


    




	 # # test the named scope 'chronological'
	 # # most recent visit 
  #   should "have all the visits are listed here in desc order" do
  #     assert_equal 3, Visit.chronological.size # quick check of size
  #     dates = Array.new
  #     # get array of visit dates in order
  #     [2,5,6].sort.each {|n| dates << n.months.ago.to_date}
  #     assert_equal dates, Visit.chronological.map{|v| v.date}
  #   end

  #   # test the scope 'chronological'
  #   should "shows that procedure_costs are listed in chronological order" do
  #     assert_equal [@checkup_c1, @xray_c1, @dental_c1, @checkup_c2], ProcedureCost.chronological.to_a
    

 end 
  
end

module Contexts
	module Assignments

		def create_assignments
			# @assign_1 = FactoryBot.create(:assignment, store: @panda, employee: @matthew, start_date: 12.months.ago.to_date, end_date: 11.months.ago.to_date)
			# @assign_2 = FactoryBot.create(:assignment, store: @target, employee: @matthew, start_date: 10.months.ago.to_date)
			# @assign_3 = FactoryBot.create(:assignment, store: @walmart, employee: @young, start_date: 9.months.ago.to_date, end_date: 2.months.ago.to_date)
			# @assign_4 = FactoryBot.create(:assignment, store: @trader, employee: @chen, start_date: 6.months.ago.to_date, end_date: 5.months.ago.to_date)
			# @assign_5 = FactoryBot.create(:assignment, store: @target, employee: @young, start_date: 1.months.ago.to_date)
			# @assign_6 = FactoryBot.create(:assignment, store: @target, employee: @chen)
			# @assign_7 = FactoryBot.create(:assignment, store: @target, employee: @chen, start_date: 2.month.ago.to_date, end_date: 1.month.ago.to_date)

			# @assign_7.employee = @evan
			# @assign_7.save

			@matt_assign_1 = FactoryBot.create(:assignment, store: @panda, employee: @matthew, start_date: 12.months.ago.to_date, end_date: 11.months.ago.to_date)
			@matt_assign_2 = FactoryBot.create(:assignment, store: @target, employee: @matthew, start_date: 9.months.ago.to_date)
			@young_assign_1 = FactoryBot.create(:assignment, store: @panda, employee: @young, start_date: 9.months.ago.to_date, end_date: 2.months.ago.to_date)
			@young_assign_2 = FactoryBot.create(:assignment, store: @trader, employee: @young, start_date: 1.months.ago.to_date)
			@chen_assign_1 = FactoryBot.create(:assignment, store: @target, employee: @chen)


			#Active Stores: Panda, Trader, Target
			#Inactive Stores: Walmart

			#Matthew has one inactive assignment at panda, and then an active assignment at target afterwards.  
			#Young has one inactive assignment at walmart (which is inactive), and then an active assignmeent at target



			#Matthew: 2 Assignments: 1 Active and 1 nonactive 
			#Young: 2 Assignments: 1 Active and 1 nonactive 
			#Chen: 2 Assignments: 1 Active and 1 nonactive 
			#Evan: 1 assignment: 1 nonactive 

			#Chen has only worked his assignment as trader's for a month 
			
			#Young has worked his assignment for only nine months, and is started a new assignment a week ago 
		


		end 

		def destroy_assignments
			@matt_assign_1.destroy
			@matt_assign_2.destroy
			@young_assign_1.destroy
			@young_assign_2.destroy 
			@chen_assign_1.destroy
		end
 


  end
end
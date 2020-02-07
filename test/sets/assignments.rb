module Contexts
	module Assignments

		def create_assignments
			@assign_1 = FactoryBot.create(:assignment, store: @panda, employee: @matthew, start_date: 12.months.ago.to_date)
			@assign_2 = FactoryBot.create(:assignment, store: @target, employee: @matthew)
			@assign_3 = FactoryBot.create(:assignment, store: @walmart, employee: @young, start_date: 11.months.ago.to_date)
			@assign_4 = FactoryBot.create(:assignment, store: @trader, employee: @chen, start_date: 6.months.ago.to_date)
			@assign_5 = FactoryBot.create(:assignment, store: @target, employee: @young, start_date: 10.months.ago.to_date)
			@assign_6 = FactoryBot.create(:assignment, store: @target, employee: @chen)

			#Chen has only worked his assignment as trader's for a month 
			@assign_4.end_date = 5.months.ago.to_date
			@assign_4.save
			#Young has worked his assignment for only 11 months, ends today, and is starting a new assignment today
			@assign_3.end_date = Date.current.to_date
			@assign_3.save


		end 

		def destroy_assignments
			@assign_1.delete
			@assign_2.delete
			@assign_3.delete
			@assign_4.delete
			@assign_5.delete
			@assign_6.delete
		end



	end
end

module Contexts
  module AnimalMedicines

    def create_animal_medicines
      @cat_rabies         = FactoryBot.create(:animal_medicine, animal: @cat, medicine: @rabies)
      @dog_rabies         = FactoryBot.create(:animal_medicine, animal: @dog, medicine: @rabies)
      @dog_carprofen      = FactoryBot.create(:animal_medicine, animal: @dog, medicine: @carprofen)
      @cat_amoxicillin    = FactoryBot.create(:animal_medicine, animal: @cat, medicine: @amoxicillin)
      @ferret_amoxicillin = FactoryBot.create(:animal_medicine, animal: @ferret, medicine: @amoxicillin)
    end
    
    def destroy_animal_medicines
      @cat_rabies.delete
      @dog_rabies.delete
      @dog_carprofen.delete
      @cat_amoxicillin.delete
      @ferret_amoxicillin.delete
    end

  end
end
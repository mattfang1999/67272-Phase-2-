module Contexts
  module Employees 

    def create_employees
      @matthew = FactoryBot.create(:employee)
      @chen = FactoryBot.create(:employee, first_name: "Chen", last_name: "Zhang", role: "manager")
      @evan = FactoryBot.create(:employee, first_name: "Evan", active: false)

    end

    def destroy_employees
      @matthew.destroy
      @chen.destroy
      @evan.destroy

    end
  end 
end  


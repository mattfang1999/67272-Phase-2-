module Contexts
  module Employees 

    def create_employees
      @matthew = FactoryBot.create(:employee)
      @young = FactoryBot.create(:employee, first_name: "Young", last_name:"Boy", role:'employee', date_of_birth:'2003-07-14')
      @chen = FactoryBot.create(:employee, first_name: "Chen", last_name: "Zhang", role: "manager")
      @evan = FactoryBot.create(:employee, first_name: "Evan", active: false, role: 'employee')
      

    end

    def destroy_employees
      @matthew.destroy
      @young.destroy
      @chen.destroy
      @evan.destroy


    end
  end 
end  


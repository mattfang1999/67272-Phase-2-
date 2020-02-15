class Assignment < ApplicationRecord

	# Relationships
 	# -----------------------------
 	belongs_to :store 
 	belongs_to :employee

  before_create :end_previous_assignment
  before_create :has_active


 	#Scopes 
  	# -----------------------------
  	scope :current, -> { where('end_date IS NULL') }
  	scope :past, -> { where('end_date IS NOT NULL') }
  	scope :chronological, -> { order('start_date DESC', 'end_date DESC')}
  	# scope :for_store, ->(store_id) {where('store_id = ?', store_id)}
    scope :for_store, ->(store) {where('store_id = ?', store.id)}
  	scope :for_employee, ->(employee) {where('employee_id = ?', employee.id)}
  	scope :for_role, -> (role) {joins(:employee).where('role = ?', role)}
  	scope :by_store, -> { joins(:store).order('name ASC') }
  	scope :by_employee, -> { joins(:employee).order('last_name', 'first_name')}

  	#scope :for_emp_assign, ->(employee_id) {where('employee_id = ?', employee_id).where(end_date: nil)}


    #VALIDATIONS

    #Validates assignment to have no start date in the future or end dates that precede start dates 
    validates_date :start_date, :on_or_before => lambda { Date.current }
    validates_date :end_date, :allow_nil => true, :on_or_after => lambda {:start_date}
    #validates_presence_of :store

    #validates_store_and_employee_in_system :assignment



  #Methods/Callbacks 

  private 

  # def has_active_members

  #     # if (!self.employee.exists? || !self.store.exists? || !self.employee.active || !self.store.active)
  #     #     self.errors.add("Employee or Store doesn't exist or is inactive")
  #     #     return false
  #     # end
      

  #     if (!self.employee.active || !self.store.active) 
  #         #self.errors.add("Employee or Store doesn't exist or is inactive")
  #         return false
  #     end

  #     # if (self.employee.exists? == false || self.store.exists? == false || self.employee.active == false || self.store.active == false)
  #     #     self.errors.add("Employee or Store doesn't exist or is inactive")
  #     #     return false
  #     # end

  #     return true
  #     #curr_store = Store.where(id: self.store)
  # end

  def end_previous_assignment
      #we are currently (in) having a new assignment and we need to update the previous assignment 
      #Assign an end date to the previous assignment
      #this date will be the start date of the new assignment
      #1. Get the Previous Assignment 
      #2. Get the Employee's Current Assignment 
      #3. Get the current Assignment's start date 
      #4. Update the Previous Assignment's end date to that start date 
      # curr_employee = Employee.find(self.employee_id)
      # prev_assign = Assignment.current.where(employee_id: self.employee_id)

      # prev_assign.each do |item|
      #   if self.id != item.id
      #     item.update_attribute(:end_date, self.start_date)
      #   end 
      # end
      # curr_employee = Employee.find(self.employee_id)
      # prev_assign = curr_employee.current_assignment
      # unless self.employee.current_assignment == nil 
      #   #prev_assign.end_date = self.start_date
      #   self.employee.current_assignment.update_attributes(:end_date => self.start_date)
      # end 

      # curr_employee = Employee.find(self.employee_id)
      # prev_assign = curr_employee.current_assignment
      # if prev_assign.end_date == nil
      #     prev_assign.update_attributes(:end_date => self.start_date)
      # end 

      curr_employee = Employee.find(self.employee_id) #returns an employee object 
      prev_assign = Assignment.for_employee(curr_employee).current.first #returns an employee object
      #prev_assign.update_attributes(:end_date => self.start_date) unless prev_assign.nil?
      puts(prev_assign)
      prev_assign.update_attribute(:end_date, self.start_date) unless prev_assign == nil



      #@object -  @matt.height, 
      #object



      # prev_assign = curr_employee.current_assignment
      # unless prev_assign == nil 
      #    prev_assign.end_date = self.start_date
      # end 

      #prev_assign.end_date = self.start_date

      # emp_id = self.find(employee_id)
      # prev_assign = self.current
  end





def has_active
  #get an array of all active stores 
  all_store_ids = Store.active.all.map{|a| a.id}
  #get an array of all active employees 
  all_employee_ids = Employee.active.all.map{|e| e.id}

  # add error unleess the store id of the assignment is in the Creamery System 
  unless all_store_ids.include?(self.store_id)
    puts("Store is not active")
    errors.add(:store, "is not an active store in creamery")
    return false 
  end 

  unless all_employee_ids.include?(self.employee_id)
    puts("Failed Employee")
    errors.add(:employee, "is not an active store in creamery")
    return false 
  end

  # if (!self.employee.active || !self.store.active)
  #   puts('Employee or store not active')
  #   return false
  # end

  return true

end

  

  
  
end

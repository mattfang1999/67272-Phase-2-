class Assignment < ApplicationRecord

	# Relationships
 	# -----------------------------
 	belongs_to :store 
 	belongs_to :employee

  before_save :end_previous_assignment


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



  #Methods/Callbacks 

  def end_previous_assignment
      #we are currently (in) having a new assignment and we need to update the previous assignment 
      #Assign an end date to the previous assignment
      #this date will be the start date of the new assignment
      #1. Get the Previous Assignment 
      #2. Get the Employee's Current Assignment 
      #3. Get the current Assignment's start date 
      #4. Update the Previous Assignment's end date to that start date 
      #curr_employee = Employee.find(self.employee_id)
      # prev_assign = Assignment.current.where(employee_id: self.employee_id)

      # prev_assign.each do |item|
      #   if self.id != item.id
      #     item.update_attribute(:end_date, self.start_date)
      #   end 
        
      # end 

      curr_employee = Employee.find(self.employee_id)
      prev_assign = curr_employee.current_assignment
      unless prev_assign == nil 
        prev_assign.end_date = self.start_date
      end 


      # prev_assign = curr_employee.current_assignment
      # unless prev_assign == nil 
      #    prev_assign.end_date = self.start_date
      # end 

      #prev_assign.end_date = self.start_date

      # emp_id = self.find(employee_id)
      # prev_assign = self.current
  end


  

  
  
end

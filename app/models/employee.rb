

class Employee < ApplicationRecord

	# Relationships
  	# -----------------------------
  	has_many :assignments
  	has_many :stores, through: :assignments

  	#Scopes 
  	# -----------------------------
  	scope :alphabetical, -> { order('last_name, first_name') }
  	scope :active, -> { where(active: true).order(last_name: :desc) }
  	scope :inactive, -> { where.not(active: true)}
  	scope :regulars, -> { where role: 'employee'}
  	scope :managers, -> { where role: 'manager'}
  	scope :admins, -> { where role: 'admin'}
  	scope :younger_than_18, -> { where('date_of_birth > ?', 18.years.ago.to_date)}
  								#2/8/2002 vs 2/5/2002
  								#500 sec elapsed vs 450 sec elapsed
  	scope :is_18_or_older, -> { where('date_of_birth <= ?', 18.years.ago.to_date)}
  								#2/5/2002 vs 2/7/2002 (Today)
  								#less time elapsed 

  	#own scope
  	#scope :only_older_than_18, -> { where('date_of_birth < ?', 18.years.ago.to_date)}


  
  	#Other Methods
  	def name
  		last_name + ', ' + first_name
  	end
  	
  	def proper_name
  		first_name + ' ' + last_name
  	end

  	def current_assignment
  	

      #loop through each assignment in the array 
      #if the assignment's end date is not nil, then do nothing. 
      #if the assignment's end date is nil, then return that. 
      emp_assignments = Assignment.for_employee(self)
      
      
      emp_assignments.each do |item|

          if item.end_date.nil?
            return item
          end

      end 

      return nil

  		
  	end

  	

  	
  	def over_18
  		#get an array of all the employees who are over 18 
  		#if the current employee is in the array, return true, else return false
      #is it wrong to call a scope? 
  		eighteen_array = Employee.is_18_or_older
  		curr_emp = self
  		eighteen_array.include?(curr_emp)

  	end 

  	def age

  		emp_age = Date.current.year - self.date_of_birth.year
  		if (Date.current.month <= self.date_of_birth.month) && (Date.current.day < self.date_of_birth.day)
  			return emp_age - 1
  		else
  			return emp_age
  		end

  	end 



	
end


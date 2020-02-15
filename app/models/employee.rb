

class Employee < ApplicationRecord


    # create a callback that will strip non-digits before saving to db
    before_save :reformat_phone

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

    #VALIDATIONS
    validates_presence_of :first_name, :last_name, :role, :ssn
    #Validates phone number - dashes and spaces allowed 
    validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[- ]\d{3}[- ]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes and spaces only"
    #Validates ssn - dashes and spacse allowed 
    validates_format_of :ssn, with: /\A(\d{9}|\(?\d{3}\)?[- ]\d{2}[- ]\d{4})\z/, message: "should be 9 and delimited with dashes and spaces only"

    #Validates values are proper data type and ranges

    #Validate dob
    validates_date :date_of_birth,:on_or_before => lambda {Date.today.to_date}


  
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
      # emp_assignments = Assignment.for_employee(self)
      
      
      # emp_assignments.each do |item|
      #     if item.end_date.nil?
      #       return item
      #     end
      # end 

      # return nil


      all_assign = Assignment.for_employee(self)
      curr_assign = all_assign.current
      #if the current assignment is []
      #returns an array

      if curr_assign.empty?
        puts("Goodbyee")
        return nil
      else
        puts("Hello")
        return curr_assign
      end

      
	
  	end

  	

  	
  	def over_18?
  		#get an array of all the employees who are over 18 
  		#if the current employee is in the array, return true, else return false
      #is it wrong to call a scope? 
  		eighteen_array = Employee.is_18_or_older
  		curr_emp = self
  		eighteen_array.include?(curr_emp)

  	end 


  	# def age
  	# 	emp_age = Date.current.year - self.date_of_birth.year
  	# 	if (Date.current.month <= self.date_of_birth.month) then
   #      if Date.current.day < self.date_of_birth.day then
  	# 		    return emp_age - 1
   #      else 
   #          return emp_age
   #      end
  	# 	else
  	# 		return emp_age
  	# 	end

  	# end 

   #  21 yrs old
   #  Feb 14, 2020
    
   #  Feb 14, 1999

   #  20 yrs old 
   #  Feb 15, 1999
   #  July 14 1999

   #  emp_age -> 21

   #  BC March, April, May, Jul... >= Feb  -->emp_age - 1 

   #  if the month is Feb, Jan, we have to check for Feb 13 and before 

   
   # Feb 14 - 21
   # Feb 13 - 21
   # Feb 15 - 20
   # July 14 - 20
   # July 13 - 20 


    def age 
      
      # if (self.date_of_birth.to_date.month >= Date.today.to_date.month)
      #     if (self.date_of_birth.to_date.day >= Date.today.to_date.day)
      #         return emp_age - 1 
      #     end
      #     return emp_age
      # end 
      emp_age = Date.today.to_date.year - self.date_of_birth.to_date.year

      if (self.date_of_birth.month < Date.today.to_date.month)
        return emp_age
      elsif (self.date_of_birth.month > Date.today.to_date.month)
        return emp_age - 1 
      else (self.date_of_birth.month == Date.today.to_date.month)

          if (self.date_of_birth.day > Date.today.to_date.day)
            return emp_age - 1
          else
            return emp_age 
          end
      end 
    end 

    


    # Callback code
   private
     # We need to strip non-digits before saving to db
     def reformat_phone
       phone = self.phone.to_s  # change to string in case input as all numbers 
       phone.gsub!(/[^0-9]/,"") # strip all non-digits
       self.phone = phone       # reset self.phone to new string
     end



	
end


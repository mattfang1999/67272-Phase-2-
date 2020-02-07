

class Employee < ApplicationRecord

	# Relationships
  	# -----------------------------
  	has_many :assignments
  	has_many :stores, through: :assignments

  	#Scopes 
  	# -----------------------------
  	scope :alphabetical, -> { order('last_name, first_name') }
  	scope :active, -> { where(active: true) }
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


  

  



	
end


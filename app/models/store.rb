class Store < ApplicationRecord

	# Relationships
  	# -----------------------------
  	has_many :assignments
  	has_many :employees, through: :assignments 



  	# Scopes
  	# -----------------------------
  	# list owners in alphabetical order
  	scope :alphabetical, -> { order('name') }
  	scope :active, -> { where(active: true) }
  	scope :inactive, -> { where.not(active: true)}
  	#scope :inactive, -> { where.(inactive: true)}


  	# Other methods

  	 #'name' -- which returns the employee name as a string "last_name, first_name" in that order
  	 
  


  	

end

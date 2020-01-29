class Employee < ApplicationRecord

	# Relationships
  	# -----------------------------
  	has_many :stores, through: :assignments
  	has_many :assignments
  	
	
end

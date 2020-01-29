class Employee < ApplicationRecord

	# Relationships
  	# -----------------------------
  	belongs_to :store
  	has_many :assignments
  	
	
end

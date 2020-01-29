class Store < ApplicationRecord

	# Relationships
  	# -----------------------------
  	has_many :assignments
  	has_many :employees, through: :assignments 

  	

end

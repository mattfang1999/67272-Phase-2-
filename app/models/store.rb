class Store < ApplicationRecord

	# Relationships
  	# -----------------------------
  	has_many :assignments
  	has_many :employees, through: :assignments 



  	# Scopes
  	# -----------------------------
  	# list owners in alphabetical order
  	scope :alphabetical, -> { order('name') }
  	

  	

end

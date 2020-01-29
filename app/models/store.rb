class Store < ApplicationRecord

	# Relationships
	# -----------------------------
	has many :employees
	has many :assignments, through: :employees
	#A store has many assignments 


	# Scopes
    # -----------------------------
    # list stores in alphabetical order
    scope :alphabetical, -> { order('name') }
    # get all the stores that are active 
    scope :active, -> { where(active: true) }
    # get all the stores that are inactive
    scope :inactive, -> { where.not(active: true) }




end

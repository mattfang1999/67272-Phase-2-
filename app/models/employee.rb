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
  	scope :regular, -> { where('role = employee')}

  	#scope :for_animal,   ->(animal_id) { joins(:animal_medicines).where('animal_medicines.animal_id = ?', animal_id) }
	
end

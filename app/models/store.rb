class Store < ApplicationRecord

	# Relationships
  	# -----------------------------
  	has_many :assignments
  	has_many :employees, through: :assignments 

  	# Relationships
  # -----------------------------
  belongs_to :animal
  belongs_to :owner
  has_many :visits
  has_many :dosages, through: :visits
  has_many :treatments, through: :visits

end

class Employee < ApplicationRecord

	#Relationships 
	# -----------------------------
	has many :assignments through: :stores
	#a store has many employees and an employee can belong to many stores 
	belongs_to :store


	# Scopes
    # -----------------------------

    # orders employeees by their name
    scope :alphabetical, -> { order('last_name, first_name')}
    # returns all employees under 18 years old 
    scope :younger_than_18, -> { where()}
    # returns all employees over 18 years old 
    scope :older_than_18, -> { where()}
    # get all the employees that are active 
    scope :active, -> { where(active: true)}
    # get all the employees that are inactive
    scope :inactive, -> { where.not(active: true)}
    # get all the employees who have the role 'employee'
    scope :regulars, -> { where('role' == 'employee')}
    # get all the employees who have the role 'manager'
    scope :managers, -> { where('role' == 'manager')}
    # get all the employees who have the role 'admin'
    scope :admins, -> { where('role' == 'admin')}


 
end

class Assignment < ApplicationRecord

	# Relationships
	# -----------------------------
	belongs_to :store
	belongs_to :employee

	# Scopes
    # ----------------------------
    # current: returns all assignments that are considered current 
    scope :current, -> { where(end_date: nil) }
    # past: returns all assignments that are considered terminated 
    scope :past, -> { where(end_date: !nil)}
    # for_store: gets all assignments associated with a given store (parameter: store object)
    scope :for_store, ->(store_id) {where("store_id = ?"), store_id}
    # for_employee: gets all the assignments associated wiith a given store (parameter: employee object)
    scope :for_employee, ->(employee_id) {where("employee_id =?"), employee_id}
    # by_store: orders assignments by store 
    scope :by_store, -> { order('store_id, assignment_id')}
    # by_employee: orders assignments by employee
    scope :by_employee, -> { order('last_name, first_name, assignment_id')}
    # orders assignments chronologically with most recent assignments listed first
    scope :chronological, -> { order('end_date')}


end

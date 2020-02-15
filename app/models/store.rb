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

    #VALIDATIONS

    #Validates presence of name, street, and city 
    validates_presence_of :name, :street, :city
    #Validates unique nature of store names (How to test this?)
    validates_uniqueness_of :name
    #Validates phone number - dashes allowed 
    validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-]\d{3}[-]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
    #if zip included, it must be 5 digits only
    validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: true


    #if state is given, must be one of the choices given (no hacking this field)
    
    validates_inclusion_of :state, in: %w[PA OH WV], message: "is not an option", allow_blank: true

  #   # make sure required fields are present
  # validates_presence_of :first_name, :last_name, :email, :phone
  # # if zip included, it must be 5 digits only
  # validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: true
  # # phone can have dashes, spaces, dots and parens, but must be 10 digits
  # validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  # # email format (other regex for email exist; doesn't allow .museum, .aero, etc.)
  # # Not allowing for .uk, .ca, etc. because this is a Pittsburgh business and customers not likely to be out-of-country
  # validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"
  # # if state is given, must be one of the choices given (no hacking this field)
  # validates_inclusion_of :state, in: %w[PA OH WV], message: "is not an option", allow_blank: true
  # # if not limited to the three states, it might be better (but slightly slower) to write:
  # # validates_inclusion_of :state, in: STATES_LIST.map {|key, value| value}, message: "is not an option", allow_blank: true

  # validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1
  
  	 
  


  	

end

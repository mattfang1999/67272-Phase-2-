# require needed files
require './test/sets/stores'
require './test/sets/employees'
require './test/sets/assignments'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Stores 
  include Contexts::Employees 
  include Contexts::Assignments 
  
end
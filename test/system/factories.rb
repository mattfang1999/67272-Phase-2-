FactoryBot.define do
  
  factory :store do
    name "Panda Supermarket"
    street "5846 Forbes Avenue"
    city "Pittsburgh"
    state "PA"
    zip "15213"
    phone "4122308902"
    active true 
  end 


  factory :employee do
    first_name "Matthew"
    last_name "Fang"
    ssn "123456789"
    date_of_birth "1999-07-14"
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    role "admin"
    active true 
  end 

  factory :assignment do 
    association :store
    association :employee 
    start_date Date.current.to_date
    end_date nil
  end 

  

end
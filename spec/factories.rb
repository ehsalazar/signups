FactoryGirl.define do

  factory :user do
    name { 'Sally' }
    email { 'sally@email.com' }
    company_name { 'Uber' }
    phone_number { '5554443333' }
    password { 'password' }
  end

  factory :company do
    name { 'Uber' }
    metadata { {} }

    factory :company_with_user do
      after(:create) do |company|
        create_list(:user, 1, company: company)
      end
    end
  end

end
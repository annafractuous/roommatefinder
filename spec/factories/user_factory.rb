FactoryGirl.define do

 factory :user do
    name { Faker::Name.name }
    age { rand(18..65)}
    gender { ["Male", "Female"].sample }
    state { Faker::Address.state }
    birthdate { Faker::Date.between(120.years.ago, 18.years.ago) }
    registration_status false

  end

end

# t.string   "name"
#     t.string   "email"
#     t.integer  "age"
#     t.string   "gender"
#     t.text     "dealbreakers"
#     t.boolean  "has_apartment"
#     t.datetime "created_at",    null: false
#     t.datetime "updated_at",    null: false
#     t.string   "password"
#     t.string   "password_salt"
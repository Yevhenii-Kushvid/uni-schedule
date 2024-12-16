FactoryBot.define do
  factory :student do
    first_name { "Student first_name #{SecureRandom.hex(3)}" }
    last_name  { "Student last_name #{SecureRandom.hex(3)}" }
  end
end

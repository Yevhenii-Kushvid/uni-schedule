FactoryBot.define do
  factory :teacher do
    first_name { "Teacher first_name #{SecureRandom.hex(3)}" }
    last_name { "Teacher last_name #{SecureRandom.hex(3)}" }
  end
end

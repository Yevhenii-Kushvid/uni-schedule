FactoryBot.define do
  factory :classroom do
    name { "Classroom #{SecureRandom.hex(3)}" }
  end
end

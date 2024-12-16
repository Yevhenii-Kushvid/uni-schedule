FactoryBot.define do
  factory :subject do
    name { "Subject name #{SecureRandom.hex(3)}" }
  end
end

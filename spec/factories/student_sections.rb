FactoryBot.define do
  factory :student_section do
    student { create(:student) }
    section { create(:section) }
  end
end

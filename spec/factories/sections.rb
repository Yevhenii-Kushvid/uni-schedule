FactoryBot.define do
  factory :section do
    teacher { create(:teacher) }
    subject { create(:subject) }
    classroom { create(:classroom) }

    duration { 5 }
    start_time { Time.now.round.utc.to_datetime }
    end_time { Time.now.round.utc.to_datetime + 10.minutes * duration }
    weekly_periodity { rand(65) } # mask
  end
end

FactoryBot.define do
  factory :section do
    teacher { create(:teacher) }
    subject { create(:subject) }
    classroom { create(:classroom) }

    duration { 5 }
    start_time { Time.now.round.utc.to_datetime }
    end_time { (start_time + 10.minutes * duration).round.utc.to_datetime }

    weekly_periodity { rand(65) } # mask
  end
end

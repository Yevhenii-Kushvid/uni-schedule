FactoryBot.define do
  factory :section do
    teacher { create(:teacher) }
    subject { create(:subject) }
    classroom { create(:classroom) }

    duration { 5 }
    start_time { Time.now.utc.round.beginning_of_day + 14.hours }
    end_time { (start_time + 10.minutes * duration).to_datetime }

    weekly_periodity { rand(65) } # mask
  end
end

require 'rails_helper'

RSpec.describe Section, type: :model do
  let!(:sections_monday) { create_list(:section, 1, weekly_periodity: Section.weekly_bitemask[:monday]) }
  let!(:sections_wednesday) { create_list(:section, 7, weekly_periodity: Section.weekly_bitemask[:wednesday]) }
  let!(:sections_friday) { create_list(:section, 3, weekly_periodity: Section.weekly_bitemask[:friday]) }
  let!(:section_on_monday_and_friday) { create(:section, weekly_periodity: Section.weekly_bitemask[:monday] | Section.weekly_bitemask[:friday]) }

  describe '.find_by' do
    it 'returns sections that awailable at chosen week today' do
      expect(Section.by_day(:monday).count).to eql(2)
      expect(Section.by_day(:wednesday).count).to eql(7)
      expect(Section.by_day(:friday).count).to eql(4)
      expect(Section.by_day(:sunday).count).to eql(0)
    end
  end

  describe '.weekly_periodity_humanize' do
    it 'return list of weekdays, when section is available' do
      expect(sections_monday.sample.weekly_periodity_humanize).to eql([ :monday ])
      expect(sections_wednesday.sample.weekly_periodity_humanize).to eql([ :wednesday ])
      expect(sections_friday.sample.weekly_periodity_humanize).to eql([ :friday ])
      expect(section_on_monday_and_friday.weekly_periodity_humanize).to eql([ :monday, :friday ])
    end
  end
end

require 'rails_helper'

RSpec.describe Student, type: :model do
  describe '.section_overflow' do
    context 'when student wants to add a new section to his schedule' do
      let!(:student) { create(:student) }
      let!(:start_time_global) { Time.now }

      context 'when new timeframe start_time and end_time are inside of existing timeframe' do
        let(:section_new) { create(:section, start_time: start_time_global, duration: 5, end_time: start_time_global + 10.minutes * 5) }
        let!(:section_old) { create(:section, start_time: start_time_global - 10.minutes, duration: 8, end_time: start_time_global - 10.minutes + 10.minutes * 8) }
        let!(:section_old2) { create(:section, start_time: start_time_global + 10.minutes * 16 - 10.minutes, duration: 8, end_time: start_time_global + 10.minutes * 16 - 10.minutes + 10.minutes * 8) }
        let!(:student_section_old) { create(:student_section, student: student, section: section_old) }
        let!(:student_section_old2) { create(:student_section, student: student, section: section_old2) }

        it 'returns DOES NOT allow add of new timeframe to student' do
          allow_insertion = student.section_overflow(section_new)

          expect(allow_insertion).to be_falsey
        end
      end

      context 'when new timeframe start_time is inside of existing timeframe and end_time is not'  do
        let(:section_new) { create(:section, start_time: start_time_global, duration: 8, end_time: start_time_global + 10.minutes * 8) }
        let!(:section_old) { create(:section, start_time: start_time_global - 10.minutes, duration: 5, end_time: start_time_global - 10.minutes + 10.minutes * 5) }
        let!(:section_old2) { create(:section, start_time: start_time_global + 10.minutes * 16 - 10.minutes, duration: 8, end_time: start_time_global + 10.minutes * 16 - 10.minutes + 10.minutes * 8) }
        let!(:student_section_old) { create(:student_section, student: student, section: section_old) }
        let!(:student_section_old2) { create(:student_section, student: student, section: section_old2) }

        it 'returns DOES NOT allow add of new timeframe to student' do
          allow_insertion = student.section_overflow(section_new)
          expect(allow_insertion).to be_falsey
        end
      end

      context 'when new timeframe end_time is inside of existing timeframe and start_time is not'  do
        let(:section_new) { create(:section, start_time: start_time_global - 10.minutes, duration: 5, end_time: start_time_global - 10.minutes + 10.minutes * 5) }
        let!(:section_old) { create(:section, start_time: start_time_global, duration: 8, end_time: start_time_global + 10.minutes * 8) }
        let!(:section_old2) { create(:section, start_time: start_time_global + 10.minutes * 16 - 10.minutes, duration: 8, end_time: start_time_global + 10.minutes * 16 - 10.minutes + 10.minutes * 8) }
        let!(:student_section_old) { create(:student_section, student: student, section: section_old) }
        let!(:student_section_old2) { create(:student_section, student: student, section: section_old2) }

        it 'returns DOES NOT allow add of new timeframe to student' do
          allow_insertion = student.section_overflow(section_new)
          expect(allow_insertion).to be_falsey
        end
      end

      context 'when new timeframe start_time is earlier than of existing timeframe, and end_time is later'  do
        let(:section_new) { create(:section, start_time: start_time_global - 10.minutes, duration: 8, end_time: start_time_global - 10.minutes + 10.minutes * 8) }
        let!(:section_old) { create(:section, start_time: start_time_global, duration: 5, end_time: start_time_global + 10.minutes * 5) }
        let!(:section_old2) { create(:section, start_time: start_time_global + 10.minutes * 16 - 10.minutes, duration: 8, end_time: start_time_global + 10.minutes * 16 - 10.minutes + 10.minutes * 8) }
        let!(:student_section_old) { create(:student_section, student: student, section: section_old) }
        let!(:student_section_old2) { create(:student_section, student: student, section: section_old2) }

        it 'returns DOES NOT allow add of new timeframe to student' do
          allow_insertion = student.section_overflow(section_new)
          expect(allow_insertion).to be_falsey
        end
      end

      context 'when new timeframe start_time and end_time are earlier then existing timeframe'  do
        let(:section_new) { create(:section, start_time: start_time_global - 10.minutes * 8, duration: 5, end_time: start_time_global - 10.minutes * 8 + 10.minutes * 5) }
        let!(:section_old) { create(:section, start_time: start_time_global, duration: 5, end_time: start_time_global + 10.minutes * 5) }
        let!(:section_old2) { create(:section, start_time: start_time_global + 10.minutes * 16 - 10.minutes, duration: 8, end_time: start_time_global + 10.minutes * 16 - 10.minutes + 10.minutes * 8) }
        let!(:student_section_old) { create(:student_section, student: student, section: section_old) }
        let!(:student_section_old2) { create(:student_section, student: student, section: section_old2) }

        it 'returns allow add of new timeframe to student' do
          allow_insertion = student.section_overflow(section_new)
          expect(allow_insertion).to be_truthy
        end
      end

      context 'when new timeframe start_time and end_time are later then existing timeframe'  do
        let(:section_new) { create(:section, start_time: start_time_global + 10.minutes * 8, duration: 5, end_time: start_time_global + 10.minutes * 8 + 10.minutes * 5) }
        let!(:section_old) { create(:section, start_time: start_time_global, duration: 5, end_time: start_time_global + 10.minutes * 5) }
        let!(:section_old2) { create(:section, start_time: start_time_global + 10.minutes * 16 - 10.minutes, duration: 8, end_time: start_time_global + 10.minutes * 16 - 10.minutes + 10.minutes * 8) }
        let!(:student_section_old) { create(:student_section, student: student, section: section_old) }
        let!(:student_section_old2) { create(:student_section, student: student, section: section_old2) }

        it 'returns allow add of new timeframe to student' do
          allow_insertion = student.section_overflow(section_new)
          expect(allow_insertion).to be_truthy
        end
      end
    end
  end
end

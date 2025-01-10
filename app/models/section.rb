class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom

  has_many :students

  scope :by_day, ->(day) { where("(weekly_periodity & ?) != 0", weekly_bitemask[day]) }
  scope :conflicts, ->(section_new) do
    start_time_new = section_new.start_time.strftime("%H:%M")
    end_time_new   = section_new.end_time.strftime("%H:%M")

    query = where("(weekly_periodity & ?) != 0", section_new.weekly_periodity)
    query.where("start_time::time < ? AND end_time::time > ?", start_time_new, start_time_new)
                         .or(query.where("start_time::time < ? AND end_time::time > ?", end_time_new, end_time_new))
                         .or(query.where("start_time::time > ? AND end_time::time < ?", start_time_new, end_time_new))
  end

  before_save :preload_data
  before_save :set_duration

  before_create :prevent_if_out_of_worktime
  before_update :prevent_if_out_of_worktime

  validate :start_time
  validate :end_time

  def set_duration
    if start_time_changed? || duration_changed?
      self.end_time = start_time + 10.minutes * duration
    end

    if end_time_changed? && !duration_changed?
      self.duration = (end_time - start_time) / 10.minutes
    end
  end

  def prevent_if_out_of_worktime
    if start_time.day == end_time.day
      start_of_worktime = start_time.beginning_of_day + 7.hours + 30.minutes
      end_of_worktime   = start_time.beginning_of_day + 22.hours

      return if start_time.between?(start_of_worktime, end_of_worktime) && end_time.between?(start_of_worktime, end_of_worktime)
    end

    raise ActiveRecord::RecordNotSaved, "It's restricted to work outbound of worktime, you'll be punished with an error."
  end

  def preload_data
    self.teacher_name   = teacher.full_name if teacher_id_changed?
    self.subject_name   = subject.name if teacher_id_changed?
    self.classroom_name = classroom.name if teacher_id_changed?
  end

  def weekly_periodity_humanize
    self.class.weekly_bitemask.filter { |day, mask| !(weekly_periodity & mask).zero? }.keys
  end

  def self.weekly_bitemask
    {
      sunday:       0b0000001,
      monday:       0b0000010,
      tuesday:      0b0000100,
      wednesday:    0b0001000,
      thrusday:     0b0010000,
      friday:       0b0100000,
      saturday:     0b1000000
    }
  end
end

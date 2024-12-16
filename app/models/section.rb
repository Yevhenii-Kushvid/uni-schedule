class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom

  has_many :students

  before_save :preload_data

  def preload_data
    self.teacher_name   = teacher.full_name if teacher_id_changed?
    self.subject_name   = subject.name if teacher_id_changed?
    self.classroom_name = classroom.name if teacher_id_changed?
  end

  def weekly_periodity_humanize
    weekly_bitemask.filter { |day, mask| !(weekly_periodity & mask).zero? }.keys
  end

  private

  def weekly_bitemask
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

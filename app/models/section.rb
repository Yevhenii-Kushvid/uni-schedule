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
end

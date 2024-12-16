class Student < ApplicationRecord
  has_many :student_sections
  has_many :sections, through: :student_sections

  has_many :teachers, through: :sections
  has_many :subjects, through: :subjects
  has_many :classrooms, through: :subjects

  def schedule
  end
end

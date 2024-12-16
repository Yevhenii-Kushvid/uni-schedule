class Teacher < ApplicationRecord
  has_many :sections
  has_many :subjects,   through: :sections
  has_many :students,   through: :sections
  has_many :classrooms, through: :sections

  def full_name
    "#{first_name} #{last_name}"
  end

  def schedule
  end
end

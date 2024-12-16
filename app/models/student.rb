class Student < ApplicationRecord
  has_many :student_sections
  has_many :sections, through: :student_sections

  has_many :teachers, through: :sections
  has_many :subjects, through: :subjects
  has_many :classrooms, through: :subjects

  # [note]
  #
  # querying should be in eager load
  # to prevent n+1
  #
  def schedule
    sections
  end

  # [note]
  #
  # Overflow of existing section still coud appear
  # if admin will change duration, or start_time of section, or weekly_periodity
  #
  # Restrict admin to change it, is not the best idea,
  # because the big amount of students in UNI could petrificate any changes
  #
  def section_overflow(section_new)
    start_time_new = section_new.start_time.strftime("%H:%M")
    end_time_new   = section_new.end_time.strftime("%H:%M")

    allow_insertion = true
    section_new.weekly_periodity_humanize.each do |day|
      intersections = sections.where("start_time::time < ? AND end_time::time > ?", start_time_new, start_time_new)
                              .or(sections.where("start_time::time < ? AND end_time::time > ?", end_time_new, end_time_new))
                              .or(sections.where("start_time::time > ? AND end_time::time < ?", start_time_new, end_time_new)).by_day(day)

      allow_insertion = allow_insertion && intersections.count.zero?
    end

    allow_insertion
  end
end

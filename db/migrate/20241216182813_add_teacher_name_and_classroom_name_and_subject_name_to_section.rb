class AddTeacherNameAndClassroomNameAndSubjectNameToSection < ActiveRecord::Migration[7.2]
  def change
    add_column :sections, :teacher_name, :string
    add_column :sections, :classroom_name, :string
    add_column :sections, :subject_name, :string

    add_index :sections, [ :id, :teacher_name, :subject_name, :classroom_name, :start_time, :end_time ]
  end
end

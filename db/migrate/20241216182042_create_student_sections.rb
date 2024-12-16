class CreateStudentSections < ActiveRecord::Migration[7.2]
  def change
    create_table :student_sections do |t|
      t.references :student, null: false, foreign_key: true
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end

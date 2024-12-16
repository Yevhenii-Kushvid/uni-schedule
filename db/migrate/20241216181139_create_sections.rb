class CreateSections < ActiveRecord::Migration[7.2]
  def change
    create_table :sections do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration
      t.integer :weekly_periodity, default: 0

      t.timestamps
    end
  end
end

class CreateCoursesStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :courses_students do |t|
      t.belongs_to :course
      t.belongs_to :student
      t.timestamps
    end

    add_index :courses_students, [:course_id, :student_id], unique: true
  end
end

class CreateStudentsCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :students_courses do |t|
      t.belongs_to :student
      t.belongs_to :course
      t.timestamps
    end
  end
end

class CreateAssignmentsStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments_students do |t|
      t.belongs_to :student
      t.belongs_to :assignment
      t.float :individual_average
      t.float :adjustment_factor
      t.float :individual_project_grade
      t.float :grade
      t.string :rank
      t.decimal :individual_grade
      t.timestamps
    end
  end
end

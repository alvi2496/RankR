class CreateStudentsTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :students_teams do |t|
      t.belongs_to :course
      t.belongs_to :student
      t.belongs_to :team
      t.timestamps
    end

    add_index(:students_teams, [:course_id, :student_id, :team_id], unique: true)
  end
end

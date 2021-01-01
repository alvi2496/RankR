class Assignment < ApplicationRecord
    has_many :ranks
    belongs_to :course
    has_and_belongs_to_many :students
    has_many :assignments_students
    has_and_belongs_to_many :teams
    has_many :assignments_teams, dependent: :destroy

    enum status: [:inactive, :active]

    after_create :assign_teams, :assign_students

    private

    def assign_teams
        course = Course.find(self.course_id)
        course.teams.each do |team|
            AssignmentsTeam.create(assignment_id: self.id, team_id: team.id, grade: 0.0)
        end
    end

    def assign_students
        course = Course.find(self.course_id)
        course.students.each do |student|
            AssignmentsStudent.create(assignment_id: self.id, student_id: student.id)
        end
    end
end

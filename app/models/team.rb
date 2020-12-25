class Team < ApplicationRecord
    has_many :students
    belongs_to :course
    has_and_belongs_to_many :assignments
    has_many :assignments_teams

    after_create :assign_assignments

    def calculate_team_average(assignment_id)
        sum = 0
        self.students.each do |student|
            av = student.assignments_students.find_by(assignment_id: assignment_id).individual_average
            sum += av if av.present?
        end
        team_average = sum == 0 ? 0 : (sum / self.students.length())&.round(2)
        self.update(team_average: team_average)
        return self
    end

    private

    def assign_assignments
        course = Course.find(self.course_id)
        course.assignments.each do |assignment|
            AssignmentsTeam.create(assignment_id: assignment.id, team_id: self.id, grade: 0.0)
        end
    end
end

class AssignmentsTeam < ApplicationRecord
    belongs_to :assignment
    belongs_to :team

    def self.calculate_team_average(team_id, assignment_id)
        at = self.find_by(team_id: team_id, assignment_id: assignment_id)
        sum = 0
        at.team.students.each do |student|
            av = student.assignments_students.find_by(assignment_id: assignment_id).individual_average
            sum += av if av.present?
        end
        team_average = sum == 0 ? 0 : (sum / at.team.students.length())&.round(2)
        at = at.update(average: team_average)
        return at
    end
end

class StudentsTeam < ApplicationRecord
    belongs_to :course
    belongs_to :student
    belongs_to :team

    def self.assign_students(course_id, team_id, student_ids)
        previous_student_teams = StudentsTeam.where(course_id: course_id, team_id: team_id)
        student_ids.each do |student_id|
            already_assigned = StudentsTeam.where(course_id: course_id, student_id: student_id)
            unless already_assigned.empty?
                already_assigned.destroy_all
            end
            student_team = StudentsTeam.find_or_create_by(course_id: course_id, team_id: team_id, student_id: student_id)
            previous_student_teams = previous_student_teams - [student_team]
        end
        previous_student_teams.each do |previous_student_team|
            previous_student_team.destroy
        end
    end
end

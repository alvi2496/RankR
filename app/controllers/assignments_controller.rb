class AssignmentsController < ApplicationController
    before_action :authenticate_student!, only: [:index]
    before_action :authenticate_admin_user!, only: [:show]

    def index
        @assignments = current_student.assignments
    end

    def show
        assignment = Assignment.find(params[:id])
        teams = assignment.teams
        ranks = Rank.where(assignment_id: params[:id]).joins(:students).joins(:ranks)
        teams.each do |team|
            team.students.each do |student|
                AssignmentsStudent.calculate_score(student.id, assignment.id, team.id)
            end
            AssignmentsTeam.calculate_team_average(team.id, assignment.id)
        end
        redirect_to admin_assignment_path(assignment.id)
    end
end

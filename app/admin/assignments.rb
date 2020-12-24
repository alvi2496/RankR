ActiveAdmin.register Assignment do

  permit_params :year, :course, :name, :status, 
  :adjustment_factor_cap, :deadline, :full_grade
  
  show do
    teams = Team.all.order(team_id: :asc)
    assignment = Assignment.find(params[:id])
    ranks = assignment.ranks
    render 'teams', {
      teams: teams, ranks: ranks, 
      assignment: assignment
    }
  end
end

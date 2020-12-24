ActiveAdmin.register Assignment do

  permit_params :course_id, :name, :status, 
  :adjustment_factor_cap, :deadline, :full_grade

  form do |f|
    session = current_admin_user.sessions&.where(default_session: true)&.first
    courses = session&.courses
    f.inputs do
      # f.input :model_id, collection: Model.all.map { |m| [m.id.to_s + ' - ' + m.name, m.id] }, selected: object.model_id
      f.input :course, collection: courses
      f.input :name
      f.input :status
      f.input :adjustment_factor_cap
      f.input :full_grade
    end
    f.actions 
  end
  
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

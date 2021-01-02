ActiveAdmin.register Team do

  menu priority: 4

  permit_params :course_id, :name


  form do |f|
    session = current_admin_user.sessions&.where(default_session: true)&.first
    courses = session&.courses
    f.inputs do
      f.input :course, collection: courses
      f.input :name
    end
    f.actions 
  end

  collection_action :enroll_students, :method => :post do
    StudentsTeam.assign_students(params[:team_members][:course_id], params[:team_members][:team_id],params[:team_members][:student_ids])
    redirect_to :action => :index, :notice => "Students enrolled successfully!"
  end

  collection_action :team_grade, :method => :post do
    assignment_team = AssignmentsTeam.find_by(team_id: params[:team_grade][:team_id], assignment_id: params[:team_grade][:assignment_id])
    assignment_team.update(grade: params[:team_grade][:grade])
    redirect_to admin_assignment_path(id: params[:team_grade][:assignment_id]), :notice => "Team grade updated successfully!"
  end

  show do
    team = Team.find(params[:id])
    course = team.course
    students = course.students
    if params[:page] == 'student_enrollment'
      render 'students_enrollment', {
        team: team, course: course,
        students: students
      }
    elsif params[:page] == 'update_team_grade'
      render 'update_team_grade', {
        team: team, 
        assignment_id: params[:assignment_id]
      }
    end
  end

  index do
    selectable_column
    column :course
    column :name
    column :created_at
    column :updated_at
    column :actions do |team|
      links = []
      links << link_to('Update student enrollment', admin_team_path(id: team.id, page: 'student_enrollment'))
      links << link_to('Edit', edit_admin_team_path(team))
      links.join('  |  ').html_safe
    end
  end
end

ActiveAdmin.register Team do

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

  show do
    team = Team.find(params[:id])
    course = team.course
    students = course.students
    render 'students_enrollment', {
      team: team, course: course,
      students: students
    }
  end

  index do
    selectable_column
    column :course
    column :name
    column :created_at
    column :updated_at
    column :actions do |team|
      links = []
      links << link_to('Update student enrollment', admin_team_path(team))
      links << link_to('Edit', edit_admin_team_path(team))
      links.join('  |  ').html_safe
    end
  end
end

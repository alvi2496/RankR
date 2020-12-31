ActiveAdmin.register Student do

  permit_params :team_id, :student_id, :name, :email

  # form do |f|
  #   session = current_admin_user.sessions&.where(default_session: true)&.first
  #   courses = session&.courses
  #   teams = Team.where(course_id: courses&.pluck(:id))
  #   f.inputs do
  #     f.input :team, collection: teams.map { |t| ["#{t.course.title} - #{t.name}", t.id] }, value: teams.pluck(:id)
  #     f.input :student_id
  #     f.input :name
  #     f.input :email
  #   end
  #   f.actions 
  # end

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/students/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    Student.save_from_csv(params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  filter :team, collection: -> {
    Team.all.map { |team| [team.name, team.id] }
  }

  filter :email
  filter :student_id
  filter :name
  
  actions :all

  index do
    selectable_column
    column :name
    column :student_id
    column :email
    column :raw_password
    column "Reset password link" do |student|
      edit_password_url(student, reset_password_token: student.password_reset_token) 
    end
    column :actions do |student|
      links = []
      links << link_to('Show', admin_student_path(student))
      links << link_to('Edit', edit_admin_student_path(student))
      links.join(' ').html_safe
    end
  end

end

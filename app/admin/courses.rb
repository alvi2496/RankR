ActiveAdmin.register Course do

  menu priority: 2

  permit_params :session_id, :title

  form do |f|
    sessions = current_admin_user.sessions
    f.inputs do
      f.input :session, collection: sessions.map { |s| [s.title, s.id] }, value: sessions.pluck(:id)
      f.input :title
    end
    f.actions 
  end

  collection_action :import_csv, :method => :post do
    Student.save_from_csv(params[:dump][:file], params[:dump][:course_id])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  show do
    course = Course.find(params[:id])
    render "students_from_csv", {
      course: course
    }
  end

  index do
    selectable_column
    column :session
    column :title
    column :actions do |course|
      links = []
      links << link_to('Enroll Students', admin_course_path(course))
      links << link_to('Edit', edit_admin_course_path(course))
      links.join('  | ').html_safe
    end
  end
end

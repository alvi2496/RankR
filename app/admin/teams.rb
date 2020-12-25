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
end

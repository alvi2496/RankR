ActiveAdmin.register Session do

  menu priority: 1

  permit_params :admin_user_id, :title, :default_session, 
                courses_attributes: [:id, :title, :_destroy]

  index do
    selectable_column
    column :title
    actions
  end

  filter :title

  form do |f|
    f.inputs do
      f.input :admin_user_id, input_html: { value: current_admin_user.id }, as: :hidden
      f.input :title
      f.input :default_session unless f.object.new_record?
    end
    f.has_many :courses do |course|
      course.inputs do
        course.input :title
      end
    end
    f.actions 
  end
  
end

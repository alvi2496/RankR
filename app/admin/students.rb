ActiveAdmin.register Student do

  permit_params :student_id, :name, :email

  form do |f|
    input :student_id
    input :name
    input :email
    actions
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

ActiveAdmin.register Student do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :team_id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :student_id, :name, :github_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:team_id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :student_id, :name, :github_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    selectable_column
    column :name
    column :student_id
    column :email
    column :raw_password
    column "Reset password link" do |student|
      edit_password_url(student, reset_password_token: student.password_reset_token) 
    end
  end

end

class CreateAdminUsersCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_users_courses do |t|
      t.belongs_to :admin_user
      t.belongs_to :course
      t.timestamps
    end
  end
end

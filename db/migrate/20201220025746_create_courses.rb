class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.belongs_to :session
      t.string :title
      t.timestamps
    end
  end
end

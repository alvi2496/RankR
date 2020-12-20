class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.belongs_to :admin_user
      t.string :title
      t.boolean :default_session, default: false
      t.timestamps
    end
  end
end

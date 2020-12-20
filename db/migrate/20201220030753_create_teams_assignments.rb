class CreateTeamsAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :teams_assignments do |t|
      t.belongs_to :team
      t.belongs_to :assignment
      t.decimal :grade
      t.timestamps
    end
  end
end

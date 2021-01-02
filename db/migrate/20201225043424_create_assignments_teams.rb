class CreateAssignmentsTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments_teams do |t|
      t.belongs_to :assignment
      t.belongs_to :team
      t.decimal :grade
      t.decimal :average
      t.timestamps
    end
  end
end

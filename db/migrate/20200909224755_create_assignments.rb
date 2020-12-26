class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :course
      t.string :name
      t.integer :status
      t.float :adjustment_factor_cap
      t.decimal :full_grade
      t.timestamps
    end
  end
end

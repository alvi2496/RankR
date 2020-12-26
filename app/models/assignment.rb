class Assignment < ApplicationRecord
    has_many :ranks
    has_and_belongs_to_many :students
    has_many :assignments_students

    enum status: [:inactive, :active]

    after_create :assign_students

    def assign_students
        Student.all.each do |student|
            AssignmentsStudent.create(assignment_id: self.id, student_id: student.id)
        end
    end
end

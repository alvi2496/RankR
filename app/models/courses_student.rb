class CoursesStudent < ApplicationRecord
    belongs_to :course
    belongs_to :student

    after_create :create_assignment_students

    private

    def create_assignment_students
        self.course.assignments.each do |assignment|
            AssignmentsStudent.create(assignment_id: assignment.id, student_id: self.student_id)
        end
    end
end

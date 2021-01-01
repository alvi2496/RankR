class StudentsTeam < ApplicationRecord
    belongs_to :course
    belongs_to :student
    belongs_to :team
end

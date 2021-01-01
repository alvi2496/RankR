class Course < ApplicationRecord
    belongs_to :session
    has_many :assignments
    has_many :teams
    has_many :students_teams
    # has_and_belongs_to_many :admin_users
    # has_and_belongs_to_many :students
end

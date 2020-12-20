class AdminUsersCourse < ApplicationRecord
    belongs_to :admin_user
    belongs_to :course
end

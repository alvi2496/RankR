class Session < ApplicationRecord
    belongs_to :admin_user
    has_many :courses
end

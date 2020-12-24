class Session < ApplicationRecord
    belongs_to :admin_user
    has_many :courses

    accepts_nested_attributes_for :courses, :allow_destroy => true
end

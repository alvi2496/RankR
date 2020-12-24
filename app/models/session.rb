class Session < ApplicationRecord
    belongs_to :admin_user
    has_many :courses, dependent: :destroy

    accepts_nested_attributes_for :courses, :allow_destroy => true

    before_create :set_default_session

    private

    def set_default_session
        session = Session.where(default_session: true).first
        if session
            session.default_session = false
            session.save
        end
        self.default_session = true
    end
end

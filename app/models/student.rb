class Student < ApplicationRecord

  belongs_to :team
  has_many :authored_ranks, class_name: 'Rank', foreign_key: :ranker_id
  has_many :received_ranks, class_name: 'Rank', foreign_key: :receiver_id
  has_and_belongs_to_many :assignments
  has_many :assignments_students, dependent: :destroy
  has_and_belongs_to_many :courses

  before_create :set_student_attributes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has_already_ranked_for(assignment_id)
    self.authored_ranks.where(assignment_id: assignment_id).exists?
  end

  def can_rank?(receiver_id)
    self.team.students.pluck(:id).include? receiver_id.to_i
  end

  def has_not_ranked_for(assignment_id)
    !self.authored_ranks.where(assignment_id: assignment_id).exists?
  end

  private

  def set_student_attributes
    password = SecureRandom.base64(8)
    self.password password, 
    self.password_confirmation = password
  end
end

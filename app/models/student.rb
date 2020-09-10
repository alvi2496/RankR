class Student < ApplicationRecord

  belongs_to :team
  has_many :authored_ranks, class_name: 'Rank', foreign_key: :ranker_id
  has_many :received_ranks, class_name: 'Rank', foreign_key: :receiver_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has_already_ranked_for(assignment_id)
    self.authored_ranks.where(assignment_id: assignment_id).exists?
  end
end

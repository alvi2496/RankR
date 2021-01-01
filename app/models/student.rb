class Student < ApplicationRecord
  has_many :authored_ranks, class_name: 'Rank', foreign_key: :ranker_id
  has_many :received_ranks, class_name: 'Rank', foreign_key: :receiver_id
  has_and_belongs_to_many :assignments
  has_many :assignments_students, dependent: :destroy
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :teams

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

  def self.save_from_csv(file)
    csv_file = file.read
    CSV.parse(csv_file, headers: true) do |row|
      password = SecureRandom.base64(8)
      raw, hashed = Devise.token_generator.generate(Student, :reset_password_token)
      Student.create(
        email: row["email"], 
        password: password, 
        password_confirmation: password,
        student_id: row["student_id"],
        name: row["name"],
        github_id: row["github_id"],
        raw_password: password,
        reset_password_token: hashed,
        reset_password_sent_at: Time.now.utc,
        password_reset_token: raw 
      )
    end
  end
end

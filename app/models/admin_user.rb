class AdminUser < ApplicationRecord

  has_many :sessions
  has_and_belongs_to_many :courses

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  enum role: [:teacher, :assistant]
end

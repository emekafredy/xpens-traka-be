class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
        #  :recoverable, :rememberable, :validatable

  has_many :incomes, dependent: :destroy
  has_many :categories, dependent: :nullify

  has_one_attached :avatar

  validates :username, presence: true
end

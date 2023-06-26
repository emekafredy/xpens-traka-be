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

  validates :email, presence: true
  validates :username, presence: true
  validates :currency, presence: true

  def generate_token
    JWT.encode(
      { id: id, exp: 5.days.from_now.to_i, email: email },
      ENV['TOKEN_SECRET_KEY']
    )
  end

  def auth_token
    generate_token
  end
end

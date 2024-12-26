class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :jwt_authenticatable,
    jwt_revocation_strategy: JwtBlacklist

  def jwt_token
    JWT.encode({ user_id: id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)
  end
end

class JwtBlacklist < ApplicationRecord
  def self.revoke_tokens_for_user(user)
    create!(jti: user.jti, revoked: true)
  end
end

module RequestHelpers
  def response_json
    JSON.parse(response.body)
  end

  def auth_headers(user)
    Devise::JWT::TestHelpers.auth_headers(
      { "Accept" => "application/json", "Content-Type" => "application/json" },
      user
    )
  end
end

require 'httparty'

class Kele
  include HTTParty

  def initialize(username, password)
    response = self.class.post(base_api_endpoint("sessions"), body: {email: username, password: password})
    @auth_token = response["auth_token"]
    raise StandardError.new('Username or Password are Incorrect') unless @auth_token
  end

  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end
end

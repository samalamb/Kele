require 'httparty'
require 'json'
require './roadmap'

class Kele
  include HTTParty
  include Roadmap

  def initialize(username, password)
    response = self.class.post(base_api_endpoint('/sessions'), body: {email: username, password: password})
    @auth_token = response["auth_token"]
    raise StandardError.new('Username or Password are Incorrect') unless @auth_token
  end

  def get_me
    response = self.class.get(base_api_endpoint('users/me'), headers: { "authorization" => @auth_token })
    @current_user = JSON.parse(response.body)
  end

  # mentor_id = 2290632
  def get_mentor_availability(mentor_id)
    response = self.class.get(base_api_endpoint("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

private
  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end
end

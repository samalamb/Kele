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

    @current_user.keys.each do |key|
      self.class.send(:define_method, key.to_sym) do
        @current_user[key]
      end
    end
  end

  # mentor_id = 2290632
  def get_mentor_availability(mentor_id)
    response = self.class.get(base_api_endpoint("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

  def get_messages(message_page)
    response = self.class.get(base_api_endpoint('message_threads'), headers: { "authorization" => @auth_token })
    @messages = JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, stripped)
    response = self.class.post(base_api_endpoint('messages'), body: { "user_id": id,
                                                                      "recipient_id": recipient_id,
                                                                      "subject": subject,
                                                                      "stripped-text": stripped
                                                                    }, headers: {"authorization" => @auth_token})

      puts response
  end

private
  def base_api_endpoint(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end
end

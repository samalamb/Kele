class Kele
  include HTTParty

  def initialize(username, password)
    @base_url = 'https://www.bloc.io/api/v1'
    @auth_token = self.class.post(base_url, username, password)
  end
end

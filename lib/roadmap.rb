module Roadmap
  # rails roadmap_id = 31 /roadmaps/id
  def get_roadmap(roadmap_id)
    response = self.class.get(base_api_endpoint("roadmaps/#{roadmap_id}"), headers: { "authorization" => @auth_token })
    @roadmap = JSON.parse(response.body)
  end

  # test checkpoint_id = 1938
  def get_checkpoints(checkpoint_id)
    response = self.class.get(base_api_endpoint("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token })
    @roadmap = JSON.parse(response.body)
  end

end

# spec/support/request_spec_helper
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
  
  # Parse an object into a json parsed hash for comparison to json responses
  def obj_to_json_hash(obj)
    JSON.parse(obj.to_json)
  end
end
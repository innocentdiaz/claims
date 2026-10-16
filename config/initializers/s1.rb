S1.configure do |c|
  c.typesafe.api_key     = Rails.application.credentials.dig(:jev_api_key)
  c.typesafe.model       = "jev-latest"
  c.typesafe.base_url    = "https://api.typesafe.ai"
  c.primitives = true                      # lets us do things like: my_name = "Andrew"; my_name.noul? 'a mans name?' # => true !
end

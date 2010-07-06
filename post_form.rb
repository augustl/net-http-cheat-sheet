require "net/http"
require "uri"

uri = URI.parse("http://example.com/search")

# Shortcut
response = Net::HTTP.post_form(uri, {"q" => "My query", "per_page" => "50"})

# Full control
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Post.new(uri.request_uri)
request.set_form_data({"q" => "My query", "per_page" => "50"})
#request["Content-Type"] = "application/json"

response = http.request(request)
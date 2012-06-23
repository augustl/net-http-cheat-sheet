require "net/http"
require "uri"

uri = URI.parse("http://google.com/")
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Get.new(uri.request_uri)
request["User-Agent"] = "My Ruby Script"
request["Accept"] = "*/*"

response = http.request(request)

# Get specific header
response["content-type"]
# => "text/html; charset=UTF-8"

# Iterate all response headers.
response.each_header do |key, value|
  p "#{key} => #{value}"
end
# => "location => http://www.google.com/"
# => "content-type => text/html; charset=UTF-8"
# ...

# Alternatively, reach into private APIs.
p response.instance_variable_get("@header")
# => {"location"=>["http://www.google.com/"], "content-type"=>["text/html; charset=UTF-8"], ...}

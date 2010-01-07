require "net/http"
require "uri"

uri = URI.parse("http://google.com/")
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Get.new(uri.request_uri)
request["User-Agent"] = "My Ruby Script"
request["Accept"] = "*/*"

response = http.request(request)
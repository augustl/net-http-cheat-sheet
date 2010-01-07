require "net/http"
require "uri"

uri = URI.parse("http://google.com/")

http = Net::HTTP.new(uri.host, uri.port)
http.open_timeout = 3 # in seconds
http.read_timeout = 3 # in seconds
http.request(Net::HTTP::Get.new(uri.request_uri))
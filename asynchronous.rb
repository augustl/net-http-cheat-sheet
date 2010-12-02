# All the APIs in Net::HTTP are synchronous.
# We have to use threads.

require "net/http"
require "uri"

Thread.new do
  # Do normal Net::HTTP stuff here.
  uri = URI.parse("http://google.com/")
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.request(Net::HTTP::Get.new(uri.request_uri))
end.join


require "net/http"
require "uri"

uri = URI.parse("http://google.com/")

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

response.code             # => 301
response.body             # => The body (HTML, XML, blob, whatever)
# Headers are lowercased
response["cache-control"] # => public, max-age=2592000

# Listing all headers
response.each_header { |h| do_something(h, response[h]) } # => location = http://www.google.com/
                                                          # => content-type = text/html; charset=UTF-8
                                                          # => cache-control = public, max-age=2592000
                                                          # etc...
 
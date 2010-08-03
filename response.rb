require "net/http"
require "uri"

uri = URI.parse("http://google.com/")

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

puts response.code             # => 301
puts response.body             # => The body (HTML, XML, blob, whatever)
# Headers are lowercased
puts response["cache-control"] # => public, max-age=2592000

# Listing all headers
puts "  All headers:"
response.each_header { |h| puts "#{h} = #{response[h]}" }
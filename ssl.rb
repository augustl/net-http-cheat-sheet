require "net/https"
require "uri"

uri = URI.parse("https://secure.com/")
http = 
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
response.body
response.status
response["header-here"] # All headers are lowercase
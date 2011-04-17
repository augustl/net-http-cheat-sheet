require "net/http"
require "uri"

uri = URI.parse("http://translate.google.com/")
http = Net::HTTP.new(uri.host, uri.port)

# make first call to get cookies
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

# save cookies
cookies = response.response['set-cookie']  


# make second call
request = Net::HTTP::Get.new('/#auto|en|Pardon')

# add previously stored cookies
request['Cookie'] = cookies

response = http.request(request)

cookies = response.response['set-cookie'] # => nil


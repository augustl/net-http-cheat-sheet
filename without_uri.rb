# You don't have to use URI.parse
require "net/http"

http = Net::HTTP.new("google.com", 80)
response = http.request(Net::HTTP::Get.new("/foo/bar"))
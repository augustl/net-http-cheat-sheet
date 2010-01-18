require "net/http"
require "uri"

uri = URI.parse("http://google.com/")
http = Net::HTTP.new(uri.host, uri.port)

http.set_debug_output($stdout)
# or
http.set_debug_output($stderr)
# or
require "logger"
http.set_debug_output(Logger.new("/path/to/my.log"))

response = http.request(Net::HTTP::Get.new(uri.request_uri))
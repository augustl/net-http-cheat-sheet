require "net/http"

# Varnish uses a custom PURGE verb. A simple subclass is all it takes for
# Net::HTTP to send requests with this method.

class Purge < Net::HTTPRequest
  METHOD = "PURGE"
  REQUEST_HAS_BODY = false
  RESPONSE_HAS_BODY = false
end

http = Net::HTTP.new("localhost", "80")
response = http.request(Purge.new("/"))

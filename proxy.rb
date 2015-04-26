require 'net/http'
require 'uri'

uri = URI.parse('http://google.com')

# Net::HTTP will automatically create a proxy from the http_proxy environment variable if it is present.
ENV['http_proxy'] # => "http://myproxy.com:8080"

http = Net::HTTP.new(uri.host, uri.port)

# This request uses proxy.
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)

# But it does not work without a Net::HTTP object.
# This request doest not use proxy.
response = Net::HTTP.get_response(uri)


# You can pass proxy address to Net::HTTP constructor too.
proxy_uri = URI.parse('http://myproxy.com:8080')

http = Net::HTTP.new(uri.host, uri.port, proxy_uri.host, proxy_uri.port)

request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)


# If you are using an authenticated proxy, use Net::HTTP.start method.
Net::HTTP.start(uri.host, uri.port, proxy_uri.host, proxy_uri.port, 'proxy_user', 'proxy_pass') do |http|
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
end

# If you want to reuse Net::HTTP instance, don't forget to finish HTTP connection.
http = Net::HTTP.start(uri.host, uri.port, proxy_uri.host, proxy_uri.port, 'proxy_user', 'proxy_pass').start

request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)

# Finish HTTP connection.
http.finish if http.started?

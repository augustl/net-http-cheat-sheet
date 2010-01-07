require "net/https"
require "uri"

uri = URI.parse("https://secure.com/")
pem = File.read("/path/to/my.pem")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.cert = OpenSSL::X509::Certificate.new(pem)
http.key = OpenSSL::PKey::RSA.new(pem)
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

request = Net::HTTP::Get.new(uri.request_uri)
require "net/https"
require "uri"

uri = URI.parse("https://ssltest7.bbtest.net")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

# You can use a certificate to verify the server you're connecting to is the
# server you indented to connect to.
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
http.cert = OpenSSL::X509::Certificate.new(File.read("/path/to/cert.pem"))

# You can also use a SSL store to automatically use all the certs installed on
# your systems. Most setups have root certs for verisign, entrust, thawte, etc
#installed.
store = OpenSSL::X509::Store.new
store.set_default_paths

# You can also manually provide certs to the store. Download a cert for
# ssltest7 at https://www.thawte.com/roots and provide the full path to
# that file here, and remove `set_default_paths`.
store.add_file("/path/to/thawte_Primary_Root_CA.pem")

# Or add a OpenSSL Ruby object.
store.add_cert(OpenSSL::X509::Certificate.new(File.read("/path/to/thawte_Primary_Root_CA.pem")))

http.cert_store = store

# You can also skip verification. That may be a bad idea, though, read more here:
# http://www.rubyinside.com/how-to-cure-nethttps-risky-default-https-behavior-4010.html
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
response.body
response.status
response["header-here"] # All headers are lowercase

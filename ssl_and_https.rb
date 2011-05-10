require "net/https"
require "uri"

# A regular-ish https request.
#
# ssltest7.bbtest.net is Thawte's SSL test site. Net::HTTP will use the CA
# certificates installed on your system by default, which most likely includes
# the Thawte cert that signed ssltest7.bbtest.net.
http = Net::HTTP.new("ssltest7.bbtest.net", 443)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

response = http.request(Net::HTTP::Get.new("/"))
response.body
response.status
# .. do normal Net::HTTP response stuff here (see separate cheat sheet entry)

# You can specify custom CA certs. If your production system only connects to
# one particular server, you should specify these, and bundle them with your
# app, so that you don't depend on the pre-installed certs on the system that
# may or may not exist.
http = Net::HTTP.new("verysecure.com", 443)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

store = OpenSSL::X509::Store.new
store.set_default_paths # Optional method that will auto-include the system CAs.
store.add_cert(OpenSSL::X509::Certificate.new(File.read("/path/to/ca1.crt")))
store.add_cert(OpenSSL::X509::Certificate.new(File.read("/path/to/ca2.crt")))
store.add_file("/path/to/ca3.crt") # Alternative syntax for adding certs.
http.cert_store = store

response = http.request(Net::HTTP::Get.new("/"))


# Client certificate example. Some servers use this to authorize the connecting
# client, i.e. you. The server you connect to gets the certificate you specify,
# and they can use it to check who signed the certificate, and use the
# certificate fingerprint to identify exactly which certificate you're using.
http = Net::HTTP.new("ssltest7.bbtest.net", 443)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
http.key = OpenSSL::PKey::RSA.new(File.read("/path/to/client.key"), "optional passphrase argument")
http.cert = OpenSSL::X509::Certificate.new(File.read("/path/to/client.crt"))

response = http.request(Net::HTTP::Get.new("/"))


# You can also skip verification. This is almost certainly a bad idea, read more
# here:
# http://www.rubyinside.com/how-to-cure-nethttps-risky-default-https-behavior-4010.html
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

require "net/http"
require "uri"

# From Nick Sieger's multipart-post gem
require 'net/http/post/multipart'

uri = URI.parse("http://something.com/uploads")
file = "/path/to/your/testfile.txt"

req = Net::HTTP::Post::Multipart.new uri.request_uri,
  "file" => UploadIO.new(File.open(file), "application/octet-stream", File.basename(file))

res = Net::HTTP.start(uri.host, uri.port) do |http|
  http.request(req)
end
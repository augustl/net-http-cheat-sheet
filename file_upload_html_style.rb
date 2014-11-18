require "net/http"
require "uri"

# Token used to terminate the file in the post body. Make sure it is not
# present in the file you're uploading.
BOUNDARY = "AaB03x"

uri = URI.parse("http://something.com/uploads")
file = "/path/to/your/testfile.txt"

post_body = []
post_body << "--#{BOUNDARY}\r\n"
post_body << "Content-Disposition: form-data; name=\"datafile\"; filename=\"#{File.basename(file)}\"\r\n"
post_body << "Content-Type: text/plain\r\n"
post_body << "\r\n"
post_body << File.read(file)
post_body << "\r\n--#{BOUNDARY}--\r\n"

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri)
request.body = post_body.join
request["Content-Type"] = "multipart/form-data, boundary=#{BOUNDARY}"

http.request(request)

# Alternative method, using Nick Sieger's multipart-post gem
require "rubygems"
require "net/http/post/multipart"

request = Net::HTTP::Post::Multipart.new uri.request_uri, "file" => UploadIO.new(file, "application/octet-stream")
http = Net::HTTP.new(uri.host, uri.port)
http.request(request)

# Another alternative, using Rack 1.3 +
require 'rack'
uri     = URI.parse("http://something.com/uploads")
http    = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri)

request.body = Rack::Multipart::Generator.new(
  "form_text_field" => "random text here",
  "file"            => Rack::Multipart::UploadedFile.new(path_to_file, file_mime_type)
).dump
request.content_type = "multipart/form-data, boundary=#{Rack::Multipart::MULTIPART_BOUNDARY}"

http.request(request)

http.start do |connection|
  response = retrying_request(connection, request)
end

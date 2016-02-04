# Ruby `Net::HTTP` cheat sheet

A bunch of examples of various use cases, implemented with Ruby's `Net::HTTP` library.

# Alternatives to `Net::HTTP`

This cheat sheet was created many years ago, when invoking `Net::HTTP` directly was common. These days, there are better alternatives around, with much nicer APIs.

Compare multipart file uploads with `Net::HTTP`:

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

And file uploads with RestClient - just a single line, and no shoddy manual string concatenation:

    RestClient.post '/data', :myfile => File.new("/path/to/image.jpg", 'rb')
    
Check out RestClient! https://github.com/rest-client/rest-client

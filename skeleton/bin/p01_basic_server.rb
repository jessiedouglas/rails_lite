require 'webrick'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
<<<<<<< HEAD
server = WEBrick::HTTPServer.new(Port: 3000)

server.mount_proc("/") do |req, res|
  res.content_type = "text/text"
  res.body = req.path
end

trap('INT') { server.shutdown }
server.start
=======
>>>>>>> ef5f6831c34666b3245a7436fbdbd949f81f77a6

fs = require 'fs'
_io = require 'socket.io'

class Draft
	route: (app, socket) ->
		app.get '/javascripts/draft-client.js', (req, res) ->
			res.header "Content-Type", "application/javascript"
			res.end "var draftSocket = io.connect('#{socket}'); draftSocket.on('refresh', function (data) { window.location.reload() });"

	listen: (basedir, app, socket, actions) ->
		io = _io.listen app
		@route app, socket
		
		# This generates unique callback fns for fs.watch
		make_cb = (action, data) -> -> io.sockets.emit action, data
		
		for action,rule of actions
			for file in rule.files
				fs.watch basedir + file, make_cb action, rule.data

module.exports = new Draft
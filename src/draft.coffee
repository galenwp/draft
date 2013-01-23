fs = require 'fs'
_io = require 'socket.io'

class Draft
	route: (app) ->
		app.get '/javascripts/draft-client.js', (req, res) -> res.sendfile './node_modules/draft/lib/draft-client.js'

	listen: (basedir, app, actions) ->
		io = _io.listen app
		@route app
		
		# This generates unique callback fns for fs.watch
		make_cb = (action, data) -> -> io.sockets.emit action, data
		
		for k,action of actions
			for file in action.files
				fs.watch basedir + file, make_cb action.action, action.data

module.exports = new Draft
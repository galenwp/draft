fs = require 'fs'
_io = require 'socket.io'

class Draft
	listen: (basedir, app, actions) ->
		io = _io.listen app
		for k,action of actions
			make_cb = (action,data) -> () -> io.sockets.emit action, data
			for file in action.files
				fs.watch basedir+file, make_cb action.action, action.data

	route: (app) ->
		app.get '/javascripts/draft-client.js', (req,res) -> res.sendfile './node_modules/draft/lib/draft-client.js'

module.exports = new Draft
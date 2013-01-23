draft
=====

Draft is a simple node module for triggering changes on the client after files change on the server.

In an Express app draft looks something like this on the server:

```js
var draft = require('draft');

app.configure('development', function(){
	draft.listen(__dirname, app, {
			refresh: {
				files:['/public/javascripts/main.js'],
				data:true
			},
			update: {
				files:['/public/javascripts/other.js'],
				data:{message:'the other file changed'}
			}
	});
	draft.route(app)
});
```


And like this on the client:

```html
<script type="text/javascript" src="/socket.io/socket.io.js" />
<script type="text/javascript" src="/javascripts/draft-client.js" />
```


Binding to custom events is easy. It looks something like this on the client:

```html
draftSocket.on('message', function(data) { $('message').html(data); })
```
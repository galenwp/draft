Tsdraft
=====

Draft is a simple node module for triggering changes on the client after files change on the server. Draft isn't intended for use in production. Draft is meant to be a tool for speeding up development.

In an Express app draft looks something like this on the server:

```js
var draft = require('draft');

app.configure('development', function(){
	draft.listen(__dirname, app, "http://localhost:3000",
			{
			refresh: {
				files:['/public/javascripts/main.js'],
				data:true
			},
			update: {
				files:['/public/javascripts/other.js'],
				data:{message:'the other file changed'}
			}
	});
});
```


And like this on the client:

```html
<script type="text/javascript" src="/socket.io/socket.io.js" />
<script type="text/javascript" src="/javascripts/draft-client.js" />
```

The most basic use case for Draft is to automatically refresh the browser when client-side code changes. In this example, when the file /public/javascripts/main.js changes the page will be refreshed.

Refreshing the entire page can sometimes be undesirable. Draft is flexible, and sends events to the client based on any filesystem change. In the example above an 'update' event is sent with the JSON {message:'the other file changed'} when the file /public/javascripts/other.js is changed. 

Binding to custom events is easy. It looks something like this on the client:

```html
draftSocket.on('update', function(data) { some.Backbone.view.refresh() })
```

This can be useful for refreshing data fetched from the server when server code is changed. It could also be used to refresh CSS, reload images or re-render views. 
var draftSocket = io.connect('http://localhost:3000');
  draftSocket.on('refresh', function (data) {
    window.location.reload()
  });
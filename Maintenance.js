var http = require('http');

var server = http.createServer();
server.on('request', function(request, response) {
    response.writeHead('200', {'content-type' : 'plain/text'});
    response.write('Polynome is currently unavailable as we undergo server maintenance. We apologize for the inconvenience.');
    response.end();
});

server.listen(3002);
console.log("Maintenance message running at 3002.")
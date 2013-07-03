var http = require('http');

var server = http.createServer();
server.on('request', function(request, response) {
    response.writeHead('200', {'content-type' : 'text/html'});
    response.write('Polynome is currently unavailable as we undergo server maintenance. We apologize for the inconvenience.');
    response.end();
});


var port = 3002;
if (process.argv[2]) {
    port = parseInt(process.argv[2], 10) ;
}
server.listen(port);
console.log("Maintenance message running at " + port + ".")
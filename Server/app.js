const WebSocket = require('ws');

const server = new WebSocket.Server({ port: 8080 });

server.on('connection', socket => {
    console.log('Client connected');

    socket.on('message', (message) => {
    	const msg = JSON.parse(message)
    	if (msg.Key == "Send") {
	        server.clients.forEach(client => {
	            if (client !== socket && client.readyState === WebSocket.OPEN) {
	                client.send('{"Key":"Received","Value":"' + msg.Value + '","From":"' + msg.From + '","To":"' + msg.To + '"}')
	            }
	        });
        }
    });

    socket.on('close', () => {
    });
});

console.log("Server connected.")
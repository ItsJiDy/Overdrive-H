const WebSocket = require('ws');

const express = require('express');
const http = require('http');

const app = express();
const hs = http.createServer(app);
const server = new WebSocket.Server({ noServer: true });

app.get('/heartbeat', (req, res) => {
    res.send('OK');
});

hs.on('upgrade', (request, socket, head) => {
    const pathname = request.url;

    if (pathname === '/server') {
        server.handleUpgrade(request, socket, head, (ws) => {
            server.emit('connection', ws, request);
        });
    } else {
        socket.destroy();
    }
});

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

hs.listen(8080, () => {
    console.log("Server is listening on port 8080");
});
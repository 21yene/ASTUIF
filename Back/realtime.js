const express = require('express');
const app = express();
const httpServer = require('http').createServer(app);

const PORT = 8000;

const io = require("socket.io")(httpServer, {
    cors: {
      origin: "http://localhost:3001",
      methods: ["GET", "POST"],
      allowedHeaders: ["my-custom-header"],
      credentials: true,
    },
  });
  

const users = [];

function storeSocket(userId, from, socketId) {
  let found = false;
  users.forEach((user) => {
    if (user.from == from) {
      found = true;
    }
  });

  if (!found) {
    users.push({ userId, from, socketId });
  }
}

function findSocketByfrom(from) {
  let user = users.find((user) => user.from == from);
  return user?.socketId;
}

io.on('connection', (socket) => {
  socket.on('openChat', (user) => {
    storeSocket(user.id, user.from, socket.id);
    io.emit('userAdded', users);
  });

  socket.on('sendMessage', (msg) => {
    const socketId = findSocketByfrom(msg.from);

    if (socketId != null) {
      io.to(socketId).emit('messageSent', {
        msg: msg,
      });
    } else {
      console.log('Socket ID is NULL!');
    }
  });

  socket.on('user_disconnected', (userId) => {
    // Handle user disconnection
  });

  socket.on('disconnect', () => {
    // Handle socket disconnection
  });
});

httpServer.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

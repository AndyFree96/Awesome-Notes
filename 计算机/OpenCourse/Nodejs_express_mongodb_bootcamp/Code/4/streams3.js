const fs = require("fs");
const server = require("http").createServer();

server.on("request", (req, res) => {
  // Solution 3
  const readable = fs.createReadStream("test-file.txt");
  readable.pipe(res);
});

server.listen(5000, "127.0.0.1", () => {
  console.log("Listening...");
});

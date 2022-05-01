const http = require("http");
const url = require("url");
const fs = require("fs");

const data = fs.readFileSync(`${__dirname}/data.json`, "utf-8");
const dataObj = JSON.parse(data);

const server = http.createServer((req, res) => {
    const pathName = req.url;

    if (pathName === "/" || pathName === "/overview"){
        res.end("Overview");
    } else if (pathName === "/product"){
        res.end("Product");
    } else if (pathName === "/api") {
        res.writeHead(200, {
            'Content-Type': "application/json",
        });
        res.end(data);
    } else {
        res.writeHead(404, {
            'Content-Type': "text/html",
            'own-header': "hello-world",
        });
        res.end("<h1>Not found</h1>");
    }
});

const port = 5000;
server.listen(port, '127.0.0.1', () => {
    console.log(`Listening to requests on port ${port}`)
});



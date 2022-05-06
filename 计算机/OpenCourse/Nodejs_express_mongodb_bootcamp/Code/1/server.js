const http = require("http");
const url = require("url");
const fs = require("fs");
const replaceTemplate = require("./module/replaceTemplate");

const templateOverview = fs.readFileSync(`${__dirname}/overview.html`, "utf-8");
const templateCard = fs.readFileSync(`${__dirname}/card.html`, "utf-8");
const templateProduct = fs.readFileSync(`${__dirname}/product.html`, "utf-8");

const data = fs.readFileSync(`${__dirname}/data.json`, "utf-8");
const dataObj = JSON.parse(data);

const server = http.createServer((req, res) => {
  const {query, pathname} = url.parse(req.url, true);

  if (pathname === "/" || pathname === "/overview") {
    res.writeHead(200, {
      "Content-Type": "text/html",
    });

    const cardsHTML = dataObj.map(el => replaceTemplate(templateCard, el)).join("");
    const overviewHTML = templateOverview.replace(/{%CARDS%}/g, cardsHTML);

    res.end(overviewHTML);
  } else if (pathname === "/product") {
    const product = dataObj[query.id-1];
    res.writeHead(200, {"Content-Type": "text/html"});
    const prodcutHTML = replaceTemplate(templateProduct, product);
    res.end(prodcutHTML);
  } else if (pathname === "/api") {
    res.writeHead(200, {
      "Content-Type": "application/json",
    });
    res.end(data);
  } else {
    res.writeHead(404, {
      "Content-Type": "text/html",
      "own-header": "hello-world",
    });
    res.end("<h1>Not found</h1>");
  }
});

const port = 5000;
server.listen(port, "127.0.0.1", () => {
  console.log(`Listening to requests on port ${port}`);
});

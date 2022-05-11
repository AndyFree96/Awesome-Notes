const EventEmitter = require("events");

class Sales extends EventEmitter {
  constructor() {
    super();
  }
}

const myEmitter = new Sales();

myEmitter.on("newSale", () => {
  console.log("There was a new sale!");
});

myEmitter.on("newSale", () => {
  console.log("Customer name : John");
});

myEmitter.on("newSale", (stock) => {
  console.log(`There are ${stock} items left in stock.`);
});

myEmitter.emit("newSale", 3);

const fs = require("fs");

// Read data from a text file
const textIn = fs.readFileSync("./1.txt", "utf-8");
console.log(textIn);

// Write data to a text file
const textOut = `NodeJS is awesome.`;
fs.writeFileSync("./2.txt", textOut);

console.log("File written!");

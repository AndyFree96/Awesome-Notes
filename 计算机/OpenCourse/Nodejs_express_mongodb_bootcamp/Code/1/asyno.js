const fs = require("fs");

fs.readFile("./start.txt", "utf-8", (err1, data1) => {
    fs.readFile(`./${data1}.txt`, "utf-8", (err2, data2) => {
        console.log(data2);
    })
});

console.log("reading file...")
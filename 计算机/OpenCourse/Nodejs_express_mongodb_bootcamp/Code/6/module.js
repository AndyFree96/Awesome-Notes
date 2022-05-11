console.log(arguments);
console.log(require("module").wrapper);

const Calculator = require("./test-module-2");
const cal1 = new Calculator();
console.log(cal1.add(13, 3));

const cal2 = require("./test-module-3");
console.log(cal2.add(12, 3));

const { add, divide } = require("./test-module-3");
console.log(add(23, 3));
console.log(divide(5, 4));

require("./test-module-4")();
require("./test-module-4")();
require("./test-module-4")();
require("./test-module-4")();

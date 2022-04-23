const recordVideoOne = new Promise((resolve, reject) => {
    resolve("Video 1 Recorded")
});

const recordVideoTwo = new Promise((resolve, reject) => {
    resolve("Video 2 Recorded")
});

const recordVideoThree = new Promise((resolve, reject) => {
    resolve("Video 3 Recoreed")
});

Promise.all([recordVideoOne, recordVideoTwo, recordVideoThree]).then(message => {
    console.log("message : ", message);
}).catch(message => {
    console.log("message : ", message);
})
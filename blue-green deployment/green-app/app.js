const express = require("express");

const app = express();
const PORT = process.env.PORT || 3000;

// Version environment variable
const VERSION = process.env.APP_VERSION || "BLUE";

app.get("/", (req, res) => {
    res.json({
        message: `Hello from ${VERSION} version V2`,
        hostname: require("os").hostname(),
        time: new Date()
    });
});

app.get("/health", (req, res) => {
    res.status(200).send("OK");
});

app.listen(PORT, () => {
    console.log(`App running on port ${PORT}`);
    console.log(`Application version: ${VERSION}`);
});
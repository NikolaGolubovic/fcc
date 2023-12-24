// index.js
// where your node app starts

// init project
var express = require("express");
var app = express();

// enable CORS (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)
// so that your API is remotely testable by FCC
var cors = require("cors");
app.use(cors({ optionsSuccessStatus: 200 })); // some legacy browsers choke on 204

// http://expressjs.com/en/starter/static-files.html
app.use(express.static("public"));

// http://expressjs.com/en/starter/basic-routing.html
app.get("/", function (req, res) {
  res.sendFile(__dirname + "/views/index.html");
});

app.get("/api/:date?", (req, res) => {
  function isValidDate(d) {
    return d instanceof Date && !isNaN(d);
  }
  const dateParams = !isNaN(Number(req.params.date)) ? Number(req.params.date) : req.params.date;
  const date = req.params.date === undefined ? new Date(Date.now()) : new Date(dateParams);
  if (!isValidDate(date)) {
    return res.json({ error: "Invalid Date" });
  }
  const unix = date.getTime();
  const utc = date.toUTCString();
  return res.json({ unix, utc });
});

// your first API endpoint...
app.get("/api/hello", function (req, res) {
  res.json({ greeting: "hello API" });
});

// listen for requests :)
const port = process.env.PORT || 3000;
var listener = app.listen(port, function () {
  console.log("Your app is listening on port " + listener.address().port);
});

require("dotenv").config();
const express = require("express");
const cors = require("cors");
const dns = require("dns");
const url = require("url");
const app = express();

// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());
// This line is necessary for parsing URL-encoded bodies (from form submits)
app.use(express.urlencoded({ extended: true }));

app.use("/public", express.static(`${process.cwd()}/public`));

app.get("/", function (req, res) {
  res.sendFile(process.cwd() + "/views/index.html");
});

const urls = [];
app.post("/api/shorturl", (req, res) => {
  function isValidUrl(url) {
    try {
      new URL(url);
      return true;
    } catch (err) {
      return false;
    }
  }
  const urlParam = req.body.url;
  const hostname = new url.URL(urlParam).hostname;
  dns.lookup(hostname, (err) => {
    if (err) {
      return res.json({ error: "Invalid URL" });
    } else {
      let foundUrlIndex;
      urls.forEach((urlObj, index) => {
        if (urlObj.original_url === urlParam) {
          foundUrlIndex = index;
        }
      });
      if (foundUrlIndex || foundUrlIndex === 0) {
        return res.json(urls[foundUrlIndex]);
      }
      const newUrlObj = { original_url: urlParam, short_url: urls.length + 1 };
      urls.push(newUrlObj);
      res.json(newUrlObj);
    }
  });
});

app.get("/api/shorturl/:short", (req, res) => {
  console.log(req.params.short);
  const shortId = +req.params.short;
  const foundUrl = urls.find((urlObj) => urlObj.short_url === shortId);
  res.redirect(foundUrl.original_url);
});

// Your first API endpoint
app.get("/api/hello", function (req, res) {
  res.json({ greeting: "hello API" });
});

app.listen(port, function () {
  console.log(`Listening on port ${port}`);
});

require("dotenv").config();
const express = require("express");
const cors = require("cors");

const { ObjectId } = require("mongodb");

const app = express();

const { MongoClient } = require("mongodb");
const connectionString = process.env.ATLAS_URI || "";
const client = new MongoClient(connectionString);
let db;

async function connectToDb() {
  try {
    const conn = await client.connect();
    db = conn.db("exercise-fcc");
  } catch (e) {
    console.error(e);
  }
}

const dbPromise = connectToDb().then(() => db);

const http = require("http").createServer(app);
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.use(cors());
app.use(express.static("public"));
app.get("/", (req, res) => {
  res.sendFile(__dirname + "/views/index.html");
});

app.get("/api/users", async (req, res) => {
  try {
    const db = await dbPromise;
    const users = db.collection("users");
    const allUsers = await users.find().toArray();
    res.status(200).json(allUsers);
  } catch (err) {
    console.error(err);
    res.status(500).send(err);
  }
});

app.post("/api/users", async (req, res) => {
  try {
    const db = await dbPromise;
    const users = db.collection("users");
    const userObj = { username: req.body.username };
    const result = await users.insertOne(userObj);
    res.status(200).json(userObj);
  } catch (err) {
    console.error(err);
    res.status(500).send(err);
  }
});

app.post("/api/users/:_id/exercises", async (req, res) => {
  try {
    const db = await dbPromise;
    const exercises = db.collection("exercises");
    const users = db.collection("users");
    const userId = new ObjectId(req.params._id);
    const description = req.body.description;
    const duration = +req.body.duration;
    const date = req.body.date ? new Date(req.body.date) : new Date();

    const user = await users.findOne({ _id: userId });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    const exercise = {
      userId,
      username: user.username,
      description,
      duration,
      date,
    };
    await exercises.insertOne(exercise);

    const response = {
      _id: userId,
      username: user.username,
      description,
      duration,
      date: date.toDateString(),
    };

    res.status(200).json(response);
  } catch (err) {
    console.error(err);
    res.status(500).send(err);
  }
});

app.get("/api/users/:_id/logs", async (req, res) => {
  console.log(req.params._id);
  const db = await dbPromise;
  const exercises = db.collection("exercises");
  const users = db.collection("users");
  const userId = new ObjectId(req.params._id);
  const user = await users.findOne({ _id: userId });
  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  let query = { userId };

  if (req.query.from || req.query.to) {
    query.date = {};
    if (req.query.from) {
      query.date.$gte = new Date(req.query.from);
    }
    if (req.query.to) {
      query.date.$lte = new Date(req.query.to);
    }
  }

  let options = {};
  if (req.query.limit) {
    options.limit = Number(req.query.limit);
  }

  console.log("query, options", query, options);

  let userExercises = await exercises.find(query, options).toArray();
  userExercises = userExercises.map((exercise) => {
    return {
      description: exercise.description,
      duration: exercise.duration,
      date: exercise.date.toDateString(),
    };
  });

  res.status(200).json({ ...user, count: userExercises.length, log: userExercises });
});

const listener = http.listen(process.env.PORT || 3000, () => {
  console.log("Your app is listening on port " + listener.address().port);
});

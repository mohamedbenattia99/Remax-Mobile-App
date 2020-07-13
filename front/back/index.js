const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const routes = require("./routes/auth");
dotenv.config();
const app = express();
//port
const port = process.env.PORT || 3000;
//Middlewares
app.use(express.json());
//route middeleware
app.use("/api/user", routes);

//data base connection
mongoose.connect(
  process.env.DB_CONNECT,
  { useNewUrlParser: true, useCreateIndex: true, useUnifiedTopology: true },
  () => {
    console.log("connected to database");
  }
);

// port listening
app.listen(3000, () => {
  console.log("app listening at 3000");
});

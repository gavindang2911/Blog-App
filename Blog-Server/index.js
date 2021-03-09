const express = require("express");
const mongoose = require("mongoose");
const Port = process.env.port || 5000;
const app = express();


mongoose.connect('mongodb://localhost:27017/myapp', {useNewUrlParser: true});
const connection = mongoose.connection;
connection.once("open",()=>{
    console.log("MongoDb connected")
})

//Middleware
const userRoute = require("./routes/user");
app.use("/user", userRoute);

app.route("/").get((req, res) => res.json("first api"))

app.listen(Port, () => console.log(`running on ${Port}`));
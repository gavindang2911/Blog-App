const express = require("express");
const app = express();
const mongoose = require("mongoose");


mongoose.connect('mongodb://localhost:27017/myapp', {useNewUrlParser: true});
const connection = mongoose.connection;
connection.once("open",()=>{
    console.log("MongoDb connected")
})

const Port = process.env.port || 5000;

app.route("/").get((req, res) => res.json("first api"))

app.listen(Port, () => console.log(`running on ${Port}`));
const express = require("express");
const mongoose = require("mongoose");
const Port = process.env.port || 5000;

const app = express();



mongoose.connect('mongodb+srv://BlogUser:gavin112233a@cluster0.zugje.mongodb.net/appDB?retryWrites=true&w=majority',
{
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
}
);
const connection = mongoose.connection;
connection.once("open",()=>{
    console.log("MongoDb connected")
})

//Middleware
app.use(express.json());
const userRoute = require("./routes/user");
app.use("/user", userRoute);

app.route("/").get((req, res) => res.json("first api"))

app.listen(Port, () => console.log(`running on ${Port}`));
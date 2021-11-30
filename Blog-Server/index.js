const express = require('express');
const mongoose = require('mongoose');
const Port = process.env.PORT || 5000;

const app = express();

mongoose.connect(
  'mongodb+srv://BlogUser:gavin112233a@cluster0.zugje.mongodb.net/appDB?retryWrites=true&w=majority',
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
  }
);
const connection = mongoose.connection;
connection.once('open', () => {
  console.log('MongoDb connected');
});

//Middleware
app.use('/uploads', express.static('uploads'));
app.use(express.json());
const userRoute = require('./routes/user');
app.use('/user', userRoute);
const profileRoute = require('./routes/profile');
app.use('/profile', profileRoute);
const blogRoute = require('./routes/blogpost');
app.use('/blogPost', blogRoute);

app.route('/').get((req, res) => res.json('first api'));

app.listen(Port, '0.0.0.0', () => console.log(`running on ${Port}`));

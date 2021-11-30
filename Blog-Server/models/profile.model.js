const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const Profile = new Schema({
    username: {
        type: String,
        require: true,
        unique: true,
    },
    name: String,
    profession: String,
    DOB: String,
    titleline: String,
    about: String,
    img:{
        type: String,
        default:""
    }
},
{
    timestamps: true,
});

module.exports = mongoose.model("Profile", Profile);
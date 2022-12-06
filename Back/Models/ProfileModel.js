const mongoose = require('mongoose');

const ProfileSchema = new mongoose.Schema({
    userId:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user'
    },
    gender: {
        type: String,
    },
    dateOfBirth: {
        type: String,
    },
    phoneNumber:{
        type:Number,
    },
    city: {
        type: String,
    },
    cin: {
        type: Number,
    },
    img: {
        type: String
    }
});
const Profile = mongoose.model('profile', ProfileSchema);
module.exports = Profile;
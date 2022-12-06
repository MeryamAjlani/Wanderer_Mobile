const mongoose = require('mongoose');

const OrganizationSchema = new mongoose.Schema({
    userId:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user'
    },
    dateOfCreation: {
        type: String,
    },
    phoneNumber:{
        type:Number,
    },
    city: {
        type: String,
    },
    description: {
        type:String
    },
    img: {
        type: String
    },
    tents:{
        type:Number,
    },
    sleepingBags:{
        type:Number,
    },
    rating:
    {
        type: Number
    }
});
const Organization = mongoose.model('organization', OrganizationSchema);
module.exports = Organization;
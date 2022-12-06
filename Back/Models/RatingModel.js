const mongoose = require('mongoose')

const RatingSchema = new mongoose.Schema({

    content:{
        type :String,
    },

    userName:{
        type:String,
        required: true
    },

    userId:{
        type:String,
        required: true
    },

    rating: {
        type: Number,
        required:true
    },
   date:{
        type:String,
        required:true
    },
    center:{
        type:String,
        required: true
    },
})
const Rating = mongoose.model('rating', RatingSchema);
module.exports = Rating;
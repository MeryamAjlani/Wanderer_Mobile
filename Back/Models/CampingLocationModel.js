const mongoose = require('mongoose')

const CampingLocationSchema = new mongoose.Schema({

    name:{
        type :String,
        required:true
    },

    picture:{
        type:String,
        required: true
    },

    city: {
        type: String,
        required:true
    },
    rating:{
        type:Number,
        required:true
    },
    numbRating:{
        type:Number,
        required:true
    },
    description: {
        type: String,
        required:true
    },
    location: {
        type: { type: String },
        coordinates: [Number],
          },
})
const CampingLocation = mongoose.model('campinglocation', CampingLocationSchema);
module.exports = CampingLocation;
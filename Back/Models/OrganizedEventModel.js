const mongoose = require('mongoose')

const OrganizedEventSchema = new mongoose.Schema({

    name:{
        type :String,
        required:true
    },

    picture:{
        type:String,
        required: true
    },
    description: {
        type: String,
        required:true
    },

    price: {
        type: Number,
    },
    distanceInKm:{
        type:Number,
        required:true
    },
    totalPlaces:{
        type:Number,
        required:true
    },
   
    nbParticipants: {
        type: Number,
        required:true
    },
    date: {
        type: Date,
        required:true
    },
    numbdays:{
        type: Number,
        required:true
    },
    location: {
        type: { type: String },
        coordinates: [Number],
          },
    startCity: {
        type: String,
        required:true
    },
    street: {
        type: String,
    },
    orgId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'organization',
        required: true
    },
    featured: {
        type:Boolean,
    }
    
})
const OrganizedEvent = mongoose.model('organizedEvent', OrganizedEventSchema);
module.exports = OrganizedEvent;
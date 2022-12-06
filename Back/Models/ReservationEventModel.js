const mongoose = require('mongoose');

const ReservationEventSchema = new mongoose.Schema({
    eventId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'organizedEvent'
    },
    userId:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user'
    },
    places: {
        type: Number,
        required:true,
    },
    price: {
        type: Number,
        required:true,
    },
    tent: {
        type: Number,
        required:true,
    },
    sleepingBag: {
        type: Number,
        required:true,
    },
    date: {
        type: Date,
        required:true,
    },
    status:{
        type:Boolean,
        required:true,
    }
});
const ReservationEvent = mongoose.model('reservationEvent', ReservationEventSchema);
module.exports = ReservationEvent;
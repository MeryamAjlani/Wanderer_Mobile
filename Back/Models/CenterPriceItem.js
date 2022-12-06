const mongoose = require('mongoose')

const PriceSchema = new mongoose.Schema({
    label:{
        type :String,
        required:true
    },
    description:{
        type:String,
        required: false
    },
    price:{
        type:Number,
        required:true
    },
    center:{
        type:String,
        required: true
    },
    totalStock:{
        type:Number,
        required:true
    },
    reservedStock:{
        type:Number,
        default: 0
    }
})
const Price = mongoose.model('price', PriceSchema);
module.exports = Price;
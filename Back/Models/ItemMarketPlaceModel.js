const mongoose = require('mongoose')

const ItemMarketplaceSchema = new mongoose.Schema({

    description:{
        type :String,
    },

    name:{
        type:String,
        required: true
    },

    userId:{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'user'
    },

    price: {
        type: Number,
        required:true
    },
  
   brand:{
        type:String,
        required: true
    },
    pictures: [{
        type: String
    }],
    previewPicture:{
        type:String,
        
    },
    category:{
     type:Number,
     required:true
    }
})
const ItemMarketplace = mongoose.model('marketPlace', ItemMarketplaceSchema);
module.exports = ItemMarketplace;
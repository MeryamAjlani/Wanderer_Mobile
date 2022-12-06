const createError = require('http-errors')
const User=require('../Models/UserModel')
const e = require('express')
const ItemMarketplace = require('../Models/ItemMarketPlaceModel')
const Profile = require('../Models/ProfileModel')
const cloudinary = require('cloudinary');

cloudinary.config({
  cloud_name: 'wanderer31',
  api_key: '999749756638474',
  api_secret: '6jgeEde82rQedRNBuYnTQ4r9Rto'
});

module.exports = {

        getCategory: async (req,res,next)=>{
         
        console.log("getting items by category");
        const result=req.body
        const items= await ItemMarketplace.find({category:result.index}).populate(
          {    
            path: "userId", 
            populate: {
               path: "profile" 
            }
         } 
        );
        console.log(items)
        var categoryItems=[];
        items.forEach(el=>{
          var item={
              'previewPicture': el.previewPicture,
              'userImage': el.userId.profile.img,
              'city': el.userId.profile.city,
              'brand': el.brand,
              'itemID': el._id,
              'name': el.name,
              'price': el.price,
              'userNumber': el.userId.profile.phoneNumber,
              'userName': el.userId.fullname,
              'description': el.description,
              'pictures': el.pictures
          }
          categoryItems.push(item)
        })
       res.send(categoryItems)
    },

    addItem:async(req,res,next)=>{

      const formidable = require('formidable');
      const form = new formidable.IncomingForm();
      form.parse(req, async function (err, fields, files) {
        if (err) {
          next(err);
        }
        console.log(fields);
        let keys = Object.keys(files);
        let pictures = [];
        for(const key of keys){
          await cloudinary.v2.uploader.upload(files[key].path, (err, result) => {
            if(err){

            }else{
              pictures.push(result.public_id);
            }
           
          });
        }
        console.log(pictures);
         /*const update = {
              'picture': result.public_id
            }
            await Center.findOneAndUpdate({userId: user._id}, update);
            res.send({status:"success", image:result.public_id});*/
        /*keys.forEach(key => {
          
        });*/
        
        const user = await User.findOne({_id:req.session.user});               
        if (user) {
          const user=await Profile.findOneAndUpdate({userId:req.session.user},{phoneNumber:req.body.userNumber,city:req.body.city})
          if(user){
            
      const item= new ItemMarketplace({description:fields.description,name:fields.pname,brand:fields.brand,category:parseInt(fields.category),price:parseFloat(fields.price),userId:req.session.user,previewPictures:pictures[0],pictures:pictures})
    if(item){
      item.save()
      console.log(item)
      res.send(item)
    }     
    }
      } else {
        const error = createError(404, 'User not found');
        next(error);
      }
      });
      
    /*try{
       const id = req.session.user
      const result=req.body
      console.log(req.body)
      const user= await User.findOne({_id:id})
      if(user){
        console.log(user);
        profile = await Profile.findOne({idd: user._id});
                const update = {
                'city': req.body.city,
                'phoneNumber': req.body.userNumber,
                };
                if (profile) {
                    let updated = await Profile.findOneAndUpdate({idd: user._id}, update,{
                        new: true
                    });
                  }
                  const formidable = require('formidable');
                  const form = new formidable.IncomingForm(); 

      const item= new ItemMarketplace({description:result.description,name:result.pname,brand:result.brand,category:result.category,price:result.price,userId:id})
        console.log(req.body)
        picturesFiles=req.body.pictures
      if (!req.body.pictures)
            return res.status(400).json({ message: "No picture attached!" });
             //map through images and create a promise array using cloudinary upload function
             let multiplePicturePromise = pictureFiles.map((picture) =>
      cloudinary.v2.uploader.upload(picture.path,(err,res)=>{
        item.previewPicture=res.public_id
      })
    );
    // await all the cloudinary upload functions in promise.all, exactly where the magic happens
    let imageResponses = await Promise.all(multiplePicturePromise);
    res.status(200).json({ images: imageResponses })
      await item.save()
      res.send("done batta")
     }
    }
     catch(error){console.log(error)}*/
    },


    searchProduct: async(req,res,next)=>{
      try{
        const list = await ItemMarketplace.find({
          $or: [
            {name: { $regex: req.body.key ,$options:'i'} },
            { brand: { $regex: req.body.key,$options:'i' } }
          ]
        }).populate(
          {    
            path: "userId", // populate blogs
            populate: {
               path: "profile" // in blogs, populate comments
            }
         } 
        );
        var result=[];
        list.forEach(el=>{
          var item={
              'previewPicture': el.previewPicture,
              'userImage': el.userId.profile.img,
              'city': el.userId.profile.city,
              'brand': el.brand,
              'itemID': el._id,
              'name': el.name,
              'price': el.price,
              'userNumber': el.userId.profile.phoneNumber,
              'userName': el.userId.fullname,
              'description': el.description,
              'pictures': el.pictures
          }
          result.push(item)
        })
        res.send( result)
        
      }
      catch(error){console.log(error)}
    },
    getPreview:async(req,res,next)=>{
      try{
         let listF=[];
         var combined=[];
        for(var i=0;i<8;i++)
        { const list = await ItemMarketplace.find({category:i}).select('previewPicture').limit(5)
        list.forEach(el=>{
          listF.push(el.previewPicture)
        })
        listF=[]
        combined.push({
          category:i,
          previewPictures:listF
        })
        }
      }
      catch(error){console.log(error)}
    }
    
}


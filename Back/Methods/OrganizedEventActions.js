const createError = require('http-errors')
const User=require('../Models/UserModel')
const e = require('express');
const OrganizedEvent = require('../Models/OrganizedEventModel');
const cloudinary = require('cloudinary');

cloudinary.config({
    cloud_name:'wanderer31',
    api_key: '999749756638474',
    api_secret:'6jgeEde82rQedRNBuYnTQ4r9Rto'
});

module.exports = {
    sortOrganizedEvent: async (req,res,next)=>{
        if(!req.session.user){
          res.status(403).send({'error':'error_403: unauthized access'});
          return;
        }
        let sort;
        let closest = {};
       
        switch (req.body.filterKey) {
          case '0':
            break;
          case '1':
            const long = (req.body.long != '') ? req.body.long : null;
            const lat = (req.body.lat != '') ? req.body.lat : null;
            if (long && lat) {
              closest = {
                location:
                  { $near :
                     {
                       $geometry: { type: "Point",  coordinates: [ long, lat ] },
                  }
                  }
                }
            } else {
              next(error);
            }
            break;
          case '2':
            sort = {rating: -1};
            break;
          case '3':
            sort = {price: 1};
            break;
          case '4':
            sort = {price: -1};
            break;
          };
        const page = req.body.page ? req.body.page : 1;
        const limit = 3;
        const skip = (page - 1 ) * limit;
        await OrganizedEvent.find(closest, function(err, result) {
          if (err) {
            res.send(err);
          } else {
            console.log(result);
            res.send(result);
          }
        }).sort(sort).limit(limit).skip(skip);
      },
      searchOrganizedEvent: async (req,res,next)=>{
        if(!req.session.user){
          res.status(403).send({'error':'error_403: unauthized access'});
          return;
        }
        let sort;
        let closest = {};
        switch (req.body.filterKey) {
          case '0':
            break;
          case '1':
            const long = (req.body.long != '') ? req.body.long : null;
            const lat = (req.body.lat != '') ? req.body.lat : null;
            if (long && lat) {
              closest = {
                location:
                  { $near :
                     {
                       $geometry: { type: "Point",  coordinates: [ long, lat ] },
                  }
                  }
                }
            } else {
              next(error);
            }
            break;
          case '2':
            sort = {rating: -1};
            break;
          case '3':
            sort = {price: 1};
            break;
          case '4':
            sort = {price: -1};
            break;
          };
        const page = req.body.page ? req.body.page : 1;
        const limit = 3;
        const skip = (page - 1 ) * limit;
        const search = [{ name: new RegExp(req.body.searchKey, 'i') }, { city: new RegExp(req.body.searchKey, 'i') }]
        await OrganizedEvent.find(closest, function(err, result) {
          if (err) {
            res.send(err);
          } else {
            res.send(result);
          }
        }).or(search)
        .sort(sort).limit(limit).skip(skip);
      },

    addOrganizedEvent: async(req,res,next)=>{
      
      const organisation = await User.findOne({ email: req.session.email });
      if (organisation) {
        req.body.orgId = organisation._id;
        delete(req.body._id);
        const event = new OrganizedEvent(req.body);
        const saved = await event.save();
        if (saved) {
          res.send({'event': saved, 'status': true});
        } else {
          //error
          console.log({'error': saved, 'status':false});
        }
      }
    },
    updateOrganizedEvent: async(req,res,next)=>{
      if(!req.session.user){
        res.status(403).send({'error':'error_403: unauthized access'});
        return;}
      const reqEvent = req.body.event;
      console.log(reqEvent);

      const event = await OrganizedEvent.findOne({ _id: req.body.id});
      if (event) {
        let updated = await OrganizedEvent.findOneAndUpdate({_id: req.body.id}, reqEvent,{
          new: true
      });
        if (updated) {
          res.send({'event': updated, 'status': true});
        } else {
          //error
          console.log({'error': updated, 'status':false});
        }
      }
    },
    uploadPicture: async (req, res, next) => {
      if(!req.session.user){
        res.status(403).send({'error':'error_403: unauthized access'});
        return;}
      try {
        
          const formidable = require('formidable');
          const form = new formidable.IncomingForm();
          form.parse(req, function(err, fields, files) {
              const {id} = fields;
              if (err) {
                  next(err);
              }
                  cloudinary.v2.uploader.upload(files.image.path, async function (err, result) {
                  const event = await OrganizedEvent.findOne({_id:id});
          if (event){
                  const update = {
                      'picture': result.public_id
                  }
                  let updated = await OrganizedEvent.findOneAndUpdate({_id: id}, update, {
                    new: true
                });
                res.send({status:"success", image:result.public_id});
          }else {
                  const error =createError(404,'Event not found');
                  next(error);
                  }
              });         
         
      });         
      } catch (error) {
          console.log('uploadPicture error: ', error);
          next(error);
      }
  }
}
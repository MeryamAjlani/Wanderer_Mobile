const createError = require('http-errors')
const User=require('../Models/UserModel')
const e = require('express');
const CampingLocation = require('../Models/CampingLocationModel');

module.exports = {
    getCampingLocationList: async (req,res,next)=>{
        console.log("getting list");
        await CampingLocation.find({}, function(err, result) {
        if (err) {
          res.send(err);
        } else {
          res.send(result);
        }
      });
    },

    sortSites: async (req,res,next)=>{
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
        };
      const page = req.body.page ? req.body.page : 1;
      const limit = 3;
      const skip = (page - 1 ) * limit;
      await CampingLocation.find(closest, function(err, result) {
        if (err) {
          res.send(err);
        } else {
          console.log(result);
          res.send(result);
        }
      }).sort(sort).limit(limit).skip(skip);
    },
    searchSites: async (req,res,next)=>{
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
      };
      const page = req.body.page ? req.body.page : 1;
      const limit = 3;
      const skip = (page - 1 ) * limit;
      const search = [{ name: new RegExp(req.body.searchKey, 'i') }, { city: new RegExp(req.body.searchKey, 'i') }]
      await CampingLocation.find(closest, function(err, result) {
        if (err) {
          res.send(err);
        } else {
          res.send(result);
        }
      }).or(search)
      .sort(sort).limit(limit).skip(skip);
    },

    addCampingLocation: async(req,res,next)=>{
      console.log(req.body.name);
      const resultat = req.body
      const location = new CampingLocation(resultat)
      console.log(" >>" +location.name);
      const savedL= await location.save()
      console.log(" location saved");
      res.send();
    },
}
const User= require('../Models/UserModel')
const OrganizedEvent = require('../Models/OrganizedEventModel')

const createError = require('http-errors');
const cloudinary = require('cloudinary');
const Organization = require('../Models/OrganizationModel');

cloudinary.config({
    cloud_name:'wanderer31',
    api_key: '999749756638474',
    api_secret:'6jgeEde82rQedRNBuYnTQ4r9Rto'
});

module.exports = {
    //should have been merged into login to avoid using two requests each time a user loggs in
    loadProfile: async (req, res, next) => {
        try {
            const email = (req.params.email != '0') ? req.params.email : req.session.email;
            
            User.aggregate([{$match: {email: email }},
                {$lookup:
                    {
                      from: 'organizations',
                      localField: '_id',
                      foreignField: 'userId',
                      as: 'profile'
                    }}
              ],
              function(err,result) {
                  if (result) {
                    res.send({'profile': result})
                  } else {
                    console.log('loadProfile error: ', err);
                    next(err);
                  }
                })         
        } catch (error) {
            console.log('loadProfile error: ', error);
            next(error);
        }
    },
    updateProfile: async (req, res, next) => {
        try {
            const user = await User.findOne({_id:req.session.user});               
                if (user){
               
                    await Organization.findOneAndUpdate({userId: user._id}, req.body,{
                        new: true
                    }).then(()=> res.send({'status':true})).catch(()=> res.send({'status': false}));
           
               
            } else {
                const error =createError(404,'User not found');
                next(error);
            }
        }catch (error) {
            console.log('updateProfile error: ', error);
            next(error);
        }
    },
    uploadPicture: async (req, res, next) => {
        try {
            const formidable = require('formidable');
            const form = new formidable.IncomingForm();
            form.parse(req, async function(err, fields, files) {
                if (err) {
                    next(err);
                }  
                const user = await User.findOne({_id:req.session.user});               
                if (user){
                cloudinary.v2.uploader.upload(files.image.path, async function (err, result) {
                   
                        const profile = await Organization.findOne({userId: user._id});
                        const update = {
                            'img': result.public_id
                        }
                        if (profile) {
                            let updated = await Organization.findOneAndUpdate({userId: user._id}, update, {
                                new: true
                            });
                            res.send({'status': true, 'img': updated.img})
                        }else {
                            const error =createError(404,'Profile not found');
                            next(error);
                        }
                    
                });  
            } else {
                const error =createError(404,'User not found');
                next(error);
            }       
           
        });         
        } catch (error) {
            console.log('uploadPicture error: ', error);
            next(error);
        }
    },
    addOrganization: async (req, res, next) => {
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        let messageEmail = "";
        let messagePass = "";
        let messageName = "";

        try {

            if (req.body.password === "") {
                messagePass = "This field cannot be empty !"
            }
            if (req.body.fullname === "") {
                messageName = "This field cannot be empty !"
            }

            if (req.body.email === "") {
                messageEmail = "This field cannot be empty !";
            }
            else if (!re.test(String(req.body.email).toLowerCase())) {
                messageEmail = "Invalid email !";
            }
            else {
                const doesExist = await User.findOne({ email: req.body.email });

                if (doesExist) {
                    messageEmail = "Email already registered !"
                }
            }

            const u = {
                'email' : req.body.email,
                'password': req.body.password,
                'fullname': req.body.fullname,
                'role':1
            }

            if (messageEmail === "" && messageName === "" && messagePass === "") {
                const user = new User(u);
                const savedUser = await user.save();
                const profile = new Organization({ 'userId': savedUser._id });
                const savedProfile = await profile.save();

                const userS = {
                    id: savedUser._id,
                    email: savedUser.email,
                    role: savedUser.role
                }

                res.send({ 'user': userS, "status": true })
                return
            }
            else {
                res.send({ "email": messageEmail, "pass": messagePass, "name": messageName, "status": false });
            }

        }
        catch (error) {
            next(error);
        }

    },
    loadMyEventUpcoming: async (req,res,next)=>{
      
        const currDate = new Date();
               const user = await User.findOne({email:req.body.email});
            if (user){
        await OrganizedEvent.find({date: {$gte: currDate.toISOString()}, orgId: user._id}, function(err, result) {
          if (err) {
            res.send(err);
          } else {
            res.send(result);
          }
        })
      }},
      loadMyEventPast: async (req,res,next)=>{
        const currDate = new Date();
        const page = req.body.page ? req.body.page : 1;
        const limit = 3;
        const skip = (page - 1 ) * limit;
        const user = await User.findOne({email:req.body.email});
            if (user){
        await OrganizedEvent.find({date: {$lt: currDate.toISOString()}, orgId: user._id}, function(err, result) {
          if (err) {
            res.send(err);
          } else {
            res.send(result);
          }
        }).limit(limit).skip(skip);
      }},
};
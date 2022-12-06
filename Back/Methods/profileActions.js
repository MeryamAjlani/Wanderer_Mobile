const User= require('../Models/UserModel')
const Profile = require('../Models/ProfileModel')
const createError = require('http-errors');
const cloudinary = require('cloudinary');

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
                      from: 'profiles',
                      localField: '_id',
                      foreignField: 'userId',
                      as: 'profile'
                    }}
              ],
              function(err,result) {
                  if (result) {
                      console.log(result);
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
            const email = req.session.email;
            const user = await User.findOne({email:email});
            if (user){
                profile = await Profile.findOne({userId: user._id});
                if (profile) {
                    await Profile.findOneAndUpdate({userId: user._id}, req.body,{
                        new: true
                    });
                    res.send({'status': true})
                } else {
                    const error =createError(404,'Profile not found');
                    next(error);
                }
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
           
                    const profile = await Profile.findOne({userId: user._id});
                    const update = {
                        'img': result.public_id
                    }
                    if (profile) {
                        let updated = await Profile.findOneAndUpdate({userId: user._id}, update, {
                            new: true
                        });
                        res.send({'status': true , 'img': updated.img})
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
    }
};
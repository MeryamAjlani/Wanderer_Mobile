const User = require('../Models/UserModel')
const Profile = require('../Models/ProfileModel');
const Organizaztion = require('../Models/OrganizationModel')
const bcrypt = require('bcrypt');
const createError = require('http-errors');
var nodemailer = require('nodemailer');
const Code = require('../Models/CodeModel');

module.exports = {
    register: async (req, res, next) => {
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
                'role':0
            }

            if (messageEmail === "" && messageName === "" && messagePass === "") {
                const user = new User(u);
                const savedUser = await user.save();
                const profile = new Profile({ 'userId': savedUser.id });
                const savedProfile = await profile.save();
                req.session.user = savedUser._id;
                req.session.email = savedUser.email;
                req.session.role = savedUser.role;
                req.session.save();
                
                const userS = {
                    id: savedUser._id,
                    email: savedUser.email,
                    role: savedUser.role,
                    name:savedUser.fullname,
                    img: 'profileImagePlaceholder'
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

    login: async (req, res, next) => {
       
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        let messageEmail = "";
        let messagePass = "";
        try {
            if (req.body.password === "") {
                messagePass = "This field cannot be empty !"
            }
            if (req.body.email === "") {
                messageEmail = "This field cannot be empty !";
            }
            else if (!re.test(String(req.body.email).toLowerCase())) {
                messageEmail = "Invalid email !";
            }
            else {
                const user = await User.findOne({ email: req.body.email });
                if (!user) {
                    messageEmail = "Email not registered !";
                }
            }
            if (messageEmail === "" && messagePass === "") {
                const user = await User.findOne({ email: req.body.email });
                const isMatch = await user.isValidPassword(req.body.password);
                if (!isMatch) {
                    messagePass = "Invalid combination!"
                }
                else {
                    let profile;
                    switch (user.role) {
                        case 0 : 
                        profile = await Profile.findOne({userId: user._id});
                            break;
                        case 1: 
                        profile = await Organizaztion.findOne({userId: user._id});
                    }
                    const userS = {
                        id: user._id,
                        email: user.email,
                        name: user.fullname,
                        role: user.role,
                        img: profile.img //"jy49icb1zzpmrcpc7lqe"//
                    }
                    req.session.user = user._id;
                    req.session.email = user.email;
                    req.session.role = user.role;
                    req.session.save();
                    res.send({ 'user': userS, "status": true });
                    return;
                }
            }
            res.send({ "email": messageEmail, "pass": messagePass, "status": false });
        } catch (error) {
            next(error);
        }
    },


    resetPassword: async (req, res, next) => {
  
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        let messageEmail = "";
        try {
            if (req.body.email === "") {
                messageEmail = "This field cannot be empty !";
            }
            else if (!re.test(String(req.body.email).toLowerCase())) {
                messageEmail = "Invalid email !";
            }
            else {
                const user = await User.findOne({ email: req.body.email });
                if (!user) {
                  
                    messageEmail = "Email not registered !";
                }
            }
            if (messageEmail === "") {
                const user = await User.findOne({ email: req.body.email });
               await Code.findOneAndRemove({email:user.email})

                const code = Math.floor(Math.random() * 1000000);
                var date = new Date();
                const newCode = new Code({ code: code, email: req.body.email });

                const savedCode = await newCode.save();
                console.log(savedCode);
                var transporter = nodemailer.createTransport({
                    service: 'gmail',
                    auth: {
                        user: 'WandererContactTeam@gmail.com',
                        pass: 'WanderingTogether'
                    }
                });
                
                var mailOptions = {
                    from: 'WandererContactTeam@gmail.com',
                    to: user.email,
                    subject: 'Reset Password',
                    text: 'Your confirmation Code is : ' + code
                };

                transporter.sendMail(mailOptions, function (error, info) {
                    if (error) {
                        console.log(error);
                    } else {
                        console.log('Email sent: ' + info.response);
                    }
                    res.send({ "status": true })
                })
            
            } else {
                res.send({ "email": messageEmail, "status": false });
            }

        }
        catch (error) {
            next(error);
        }
    },

    confirmCode: async (req, res, next) => {
        try {
            const result = req.body
            console.log(result);
            const user = await User.findOne({ email: result.email });
            if (!user) {
                const error = createError(404, 'user not registred');
                next(error);
            }

            //retreive the code from database
            const codeDatabase = await Code.findOne({ code: result.code });
            if (!codeDatabase) {
                const error = createError(404, 'CODE NON EXISTING');
                res.send({ message: " Invalid Code !" })
            }
            else
                res.send({ message: 'pass',email:result.email })
        }
        catch (error) {
            if (error.isJoi === true) error.status = 422;
            next(error);
        }
    },

    autoLogin: async (req, res, next) => {
        try {
            if (req.session.user){
                const user = await User.findOne({ email: req.session.email });
                let profile;
                switch (req.session.role) {
                    case 0 : 
                    profile = await Profile.findOne({userId: user._id});
                        break;
                    case 1: 
                    profile = await Organizaztion.findOne({userId: user._id});
                    
                }
                const userS = {
                    id: user._id,
                    email: user.email,
                    name: user.fullname,
                    role: user.role,
                    img: profile.img//"jy49icb1zzpmrcpc7lqe"//
                }
                res.send({status:true, user: userS})}
            else
                res.send({status:false})
        }
        catch (error) {
            next(error);
        }
    },

    logout: async (req, res, next) => {
        try {
            req.session.destroy();
            res.send({ status: 'logged out' })
        }
        catch (error) {
            next(error);
        }
    },

    changePassword:async(req,res,next)=>{
        const result = req.body
        let confirmation=""
        let messagePass=""
        try{
            const user=await User.findOne({email:result.email})
            if (result.pass === "") {
                messagePass = "This field cannot be empty !"
            }
            if (result.email === "") {
                confirmation = "This field cannot be empty !"
            }
          
            if(confirmation==="" && messagePass===""){
                const user= await User.findOne({email:result.email})
               if(user){
                const salt = await bcrypt.genSalt(10);
                const hashedPassword = await bcrypt.hash(result.pass, salt);
                console.log(hashedPassword)
                   await User.updateOne({email:user.email},{password:hashedPassword})
                res.send({'password':messagePass,"confirmation ":confirmation,"status":true})
               }
                else {
                    const error = createError(404, 'USER NOT FOUND');
                    next(error)
                }
            }
            else{
                res.send({'password':messagePass,"confirmation ":confirmation,"status":false})
            }

        }
        catch (error) {
            next(error);
        }
    }
}
const User = require('../Models/UserModel');
const Organisation = require('../Models/OrganizationModel.js');
const OrganizedEvent = require('../Models/OrganizedEventModel');
const Reservation = require('../Models/ReservationEventModel');
const createError = require('http-errors');


module.exports ={

    makeReservation: async(req,res,next)=>{
        const reservationReq = req.body.reservation;
        console.log(reservationReq);
        
        console.log(reservationReq.userEmail);
        const user = await User.findOne({ email: reservationReq.userEmail });
        const organizedEvent = await OrganizedEvent.findOne({ _id: reservationReq.eventId });
    
        if (user && organizedEvent) {
          reservationReq.userEmail = user._id;
          reservationReq.eventId = organizedEvent._id;
          const reservation = new Reservation(reservationReq);
          const saved = await reservation.save();
          if (saved) {
            res.send({'reservation': saved, 'status': true});
          } else {
            //error
            console.log({'error': saved, 'status':false});
            res.send({'error': saved, 'status':false})

          }
        } else {
            console.log({'error': 'user || event not found', 'status':false});
            res.send({'error': 'user || event not found', 'status':false})

        }
      },
      getReservationsEvent: async(req,res,next)=>{
        const eventId = req.body.eventId;
        const organizedEvent = await OrganizedEvent.findOne({ _id: eventId });
        if (organizedEvent) {
          const reservations = await Reservation.find({ eventId: eventId , status: false}).populate('userEmail','fullname');
          console.log(reservations);
          res.send(reservations);
        }else{
          res.send(null);

        }
      },
      getParticipantsEvent: async(req,res,next)=>{
        const eventId = req.body.eventId;
        const organizedEvent = await OrganizedEvent.findOne({ _id: eventId });
        if (organizedEvent) {
          const reservations = await Reservation.find({ eventId: eventId , status: true}).populate('userEmail','fullname');
          console.log(reservations);
          res.send(reservations);
        }else{
          res.send(null);

        }
      },
      getMyReservations: async(req,res,next)=>{
        const userEmail = req.session.email;
        const user = await User.findOne({ email: userEmail });
        if (user) {
          const reservations = await Reservation.find({ userEmail: user._id}).populate('eventId','name');
          console.log(reservations);
          res.send(reservations);
        }else{
          res.send(null);

        }
      },
      getEventStats: async(req,res,next)=>{
        const eventId = req.body.eventId;
        const organizedEvent = await OrganizedEvent.findOne({ _id: eventId });
        if (organizedEvent) {
          const org = await Organisation.findOne({idd: organizedEvent.org})
          if (org){
            
            Reservation.aggregate([{$match: {eventId: eventId, status:false}},
              {$group: {
                _id: { eventId},
                places: {$sum: "$places"},
                tents: {$sum: "$tent"},
                sleepingBags: {$sum: "$sleepingBag"},
              }}
            ],
            function(err,pending) {
              Reservation.aggregate([{$match: {eventId: eventId, status:true}},
              {$group: {
                _id: { eventId},
                places: {$sum: "$places"},
                tents: {$sum: "$tent"},
                sleepingBags: {$sum: "$sleepingBag"},
              }}
            ],
            function(err,reserved) {
              const total = {
                'places': organizedEvent.totalPlaces,
                'tents': org.tents,
                'sleepingBags': org.sleepingBags
              };
              res.send({'pending': pending,'reserved': reserved, 'total':total})
            })
            })
          }
            
   
        }else{
          res.send(null);

        }
      },
      acceptReservation: async(req,res,next)=>{
        const reservationId = req.body.reservationId;
        const reservation = await Reservation.findOneAndUpdate({ _id: reservationId }, {status: true});
        if (reservation) {
          res.send({'status': true});
        }else{
          res.send({'status': false});

        }
      },
      acceptParticipant: async(req,res,next)=>{
        const reservationId = req.body.reservationId;
        const reservation = await Reservation.findOneAndUpdate({ _id: reservationId }, {status: true});
        if (reservation) {
          res.send({'status': true});
        }else{
          res.send({'status': false});

        }
      },

}
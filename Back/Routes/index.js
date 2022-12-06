
const express= require('express')
const router = express.Router();

const actions =require('../Methods/actions');
const profileActions = require('../Methods/profileActions');
const locationActions = require('../Methods/CampingLocationActions')
const marketPlace = require('../Methods/MarketplaceActions')

const center = require('../Methods/CenterActions');
const organizedEvent=require('../Methods/OrganizedEventActions');
const organization = require('../Methods/OrganizationActions');
const reservationEvent = require('../Methods/ReservationEventActions');

router.get('/',(req,res)=>{
    var date = new Date()
    res.send('batta')
})

router.post('/register',actions.register)
router.post('/login',actions.login)
router.post('/autoLogin',actions.autoLogin)
router.post('/logout',actions.logout)
router.post('/resetPassword',actions.resetPassword)
router.post('/confirmCode',actions.confirmCode)
router.post('/changePassword',actions.changePassword)

router.get('/loadProfile/:email',profileActions.loadProfile)
router.post('/updateProfile',profileActions.updateProfile)
router.post('/uploadProfilePicture',profileActions.uploadPicture)

router.post('/CampingCentersSort',center.sortCenters)
router.post('/CampingCentersSearch',center.searchCenters)
router.post('/OwnedCampingCenter', center.getCenterByOwner)
router.post('/updatePrices',center.updatePrices)


router.post('/addPriceItem',center.addPriceItem)
router.post('/ratings',center.rating)
router.post('/addratings',center.addrating)
router.post('/addCenter',center.addCenter)


router.post('/CampingSitesSort',locationActions.sortSites)
router.post('/CampingSitesSearch',locationActions.searchSites)
router.get('/getCampingLocationList', locationActions.getCampingLocationList)
router.post('/addCampingLocation',locationActions.addCampingLocation)
router.post('/getCamingCenterPrices',center.CampingCenterPrices)
router.post('/getUserRating',center.getUserRating)
router.post('/updateRating',center.updateRating)
router.post('/uploadCenterPicture',center.uploadPicture)
router.post('/updateCenter',center.updateCenter)


router.post('/OrganizedEventSort',organizedEvent.sortOrganizedEvent)
router.post('/OrganizedEventSearch',organizedEvent.searchOrganizedEvent)
router.post('/addOrganizedEvent',organizedEvent.addOrganizedEvent)
router.post('/updateOrganizedEvent',organizedEvent.updateOrganizedEvent)
router.post('/updateOrganizedEventImage',organizedEvent.uploadPicture)

router.post('/makeReservationEvent',reservationEvent.makeReservation)
router.post('/getReservationsByEvent',reservationEvent.getReservationsEvent)
router.post('/getParticipantsByEvent',reservationEvent.getParticipantsEvent)

router.post('/getEventsStats',reservationEvent.getEventStats);
router.post('/acceptReservation',reservationEvent.acceptReservation);
router.post('/acceptParticipant',reservationEvent.acceptParticipant);
router.post('/getMyReservations',reservationEvent.getMyReservations);





router.get('/loadOrganization/:email',organization.loadProfile)
router.post('/updateOrganization',organization.updateProfile)
router.post('/uploadPictureOrganization',organization.uploadPicture)
router.post('/loadMyEventsUpcoming',organization.loadMyEventUpcoming)
router.post('/loadMyEventsPast',organization.loadMyEventPast)
router.post('/addOrganization',organization.addOrganization)



router.post('/getCategory',marketPlace.getCategory)
router.post('/addProduct',marketPlace.addItem)
router.post('/searchProduct',marketPlace.searchProduct)
router.post('/getPreview',marketPlace.getPreview)



module.exports = router
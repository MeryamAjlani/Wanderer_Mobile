
const Center = require('../Models/CampingCenterModel')
const PriceItem = require('../Models/CenterPriceItem')
const createError = require('http-errors')
const User = require('../Models/UserModel')
const e = require('express');
const Rating = require('../Models/RatingModel');
const { PersistentFile } = require('formidable');
const cloudinary = require('cloudinary');

cloudinary.config({
  cloud_name: 'wanderer31',
  api_key: '999749756638474',
  api_secret: '6jgeEde82rQedRNBuYnTQ4r9Rto'
});

module.exports = {
  sortCenters: async (req, res, next) => {
    if (!req.session.user) {
      res.status(403).send({ 'error': 'error_403: unauthized access' });
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
            {
              $near:
              {
                $geometry: { type: "Point", coordinates: [long, lat] },
              }
            }
          }
        } else {
          next(error);
        }
        break;
      case '2':
        sort = { rating: -1 };
        break;
      case '3':
        sort = { price: 1 };
        break;
      case '4':
        sort = { price: -1 };
        break;
    };
    const page = req.body.page ? req.body.page : 1;
    const limit = 3;
    const skip = (page - 1) * limit;
    await Center.find(closest, function (err, result) {
      if (err) {
        res.send(err);
      } else {
        res.send(result);
      }
    }).sort(sort).limit(limit).skip(skip);
  },
  searchCenters: async (req, res, next) => {
    if (!req.session.user) {
      res.status(403).send({ 'error': 'error_403: unauthized access' });
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
            {
              $near:
              {
                $geometry: { type: "Point", coordinates: [long, lat] },
              }
            }
          }
        } else {
          next(error);
        }
        break;
      case '2':
        sort = { rating: -1 };
        break;
      case '3':
        sort = { price: 1 };
        break;
      case '4':
        sort = { price: -1 };
        break;
    };
    const page = req.body.page ? req.body.page : 1;
    const limit = 3;
    const skip = (page - 1) * limit;
    const search = [{ name: new RegExp(req.body.searchKey, 'i') }, { city: new RegExp(req.body.searchKey, 'i') }]
    await Center.find(closest, function (err, result) {
      if (err) {
        res.send(err);
      } else {
        res.send(result);
      }
    }).or(search)
      .sort(sort).limit(limit).skip(skip);
  },

  updateCenter: async (req, res, next) => {
    if (!req.session.user) {
      res.status(403).send({ 'error': 'error_403: unauthized access' });
      return;
    }
    await Center.findOne({ userid: req.session.user }, async function (err, result) {
      if (err) {
        res.send(err);
      } else {
        console.log(req.body);
        console.log(result['_id']);
        await Center.findOneAndUpdate({ '_id': result['_id'] }, req.body);
        res.send("success");
      }
    }
    )
  },

  addCenter: async (req, res, next) => {
    const resultat = req.body
    const center = new Center(resultat)
    const savedC = await center.save()
    res.send();
  },

  addPriceItem: async (req, res, next) => {
    const result = req.body;
    const price = new PriceItem(req.body);
    try {
      const saved = await price.save()
      res.send("yep")
    }
    catch (error) { next(error) }
  },

  CampingCenterPrices: async (req, res, next) => {
    await PriceItem.find({ center: req.body.center }, function (err, result) {
      if (err) {
        res.send(err);
      } else {
        res.send(result);
      }
    });
  },

  getCenterByOwner: async (req, res, next) => {
    await Center.findOne({ userid: req.session.user }, function (err, result) {
      if (err) {
        res.send(err);
      } else {
        res.send(result);
      }
    });
  },

  updatePrices: async (req, res, _) => {
    if (!req.session.user) {
      res.status(403).send({ 'error': 'error_403: unauthized access' });
      return;
    }
    await Center.findOne({ userid: req.session.user }, async function (err, result) {
      if (err) {
        res.send(err)
      } else {
        let accessPrice = req.body['accessPrice'];
        await Center.findOneAndUpdate({ '_id': result['_id'] }, { 'price': accessPrice })
        let updatedPrices = req.body['modItems'];
        let newPrices = req.body['newItems'];
        let deletedPrices = req.body['delItems'];
        for (const item of updatedPrices) {
          if (item['center'] != result['_id']) {
            res.status(403).send({ 'error': 'error_403: unauthized access' });
            return;
          }
          await PriceItem.findOneAndUpdate({ _id: item['_id'] }, item);
        }
        for (const item of newPrices) {
          if (item['center'] != result['_id']) {
            res.status(403).send({ 'error': 'error_403: unauthized access' });
            return;
          }
          let priceItem = PriceItem(item)
          await priceItem.save()
        }
        for (const item of deletedPrices) {
          if (item['center'] != result['_id']) {
            res.status(403).send({ 'error': 'error_403: unauthized access' });
            return;
          }
          await PriceItem.findOneAndDelete(item);
        }
        res.send("success");
      }
    });
  },


  addrating: async (req, res, next) => {
    const result = req.body;
    const userId = req.session.user
    try {
      var date1 = new Date()
      var mon = date1.getMonth() + 1
      var montS = mon.toString()
      if (mon < 9) montS = '0' + mon
      var date = date1.getFullYear() + '-' + montS + '-' + date1.getDate()
      const rating = new Rating({ content: result.content, userName: result.name, userId: userId, rating: result.rating, date: date, center: result.center });
      console.log(rating)
      console.log(userId)
      const savedR = await rating.save()
      const center = await Center.findOne({ _id: result.center })
      const ratings = await Rating.find({ center: result.center })
      const updateC = {
        'numbRating': center.numbRating + 1,
        'rating': (((center.rating * center.numbRating) + result.rating) / (center.numbRating + 1)).toFixed(1),

      };

      if (center) {
        let update = await Center.findOneAndUpdate({ _id: result.center }, updateC, {
          new: true
        });
        res.send({ message: 'rating added' })
      } else {
        const error = createError(404, 'rating not found');
        next(error);
      }
    }
    catch (error) { next(error) }

  },

  rating: async (req, res, next) => {
    try {
      const result = req.body
      var reviews = await Rating.find({ center: result.center, content: { $nin: [null, ""] } })
      reviews = reviews.sort((e1, e2) => { e1.rating - e2.rating })
      console.log(reviews.sort((e1, e2) => { return parseFloat(e2.rating) - parseFloat(e1.rating) }))
      if (reviews.length > 1)
        res.send([reviews[0], reviews[reviews.length - 1]])
      else if (reviews.length > 0)
        res.send([reviews[0]])
      else
        res.send([])
    } catch (error) { next(error) }
  },

  getUserRating: async (req, res, next) => {
    try {
      const result = req.body;
      const userId = req.session.user
      if (userId) {
        const rating = await Rating.find({ userId: userId, center: result.center })
        res.send(rating)
      }
    }
    catch (error) { next(error) }
  },

  updateRating: async (req, res, next) => {
    try {
      const result = req.body;
      const userId = req.session.user
      if (userId) {
        const rating = await Rating.findOne({ center: result.center, userId: userId })

        if (rating) {
          const updateRating = {
            'content': result.content,
            'rating': result.rating
          }
          let updateRatingN = await Rating.findOneAndUpdate({ _id: rating._id.toString() }, updateRating, {
            new: true
          });
          const center = await Center.findOne({ _id: result.center })
          if (center) {
            const updateCenter = {
              'content': result.content,
              'rating': (((center.rating * center.numbRating) + result.rating - center.rating) / (center.numbRating)).toFixed(1),
            }
            let updateCenterN = await Center.findOneAndUpdate({ _id: result.center }, updateCenter, {
              new: false
            });
          }
          else {
            res.status(403).send({ 'error': 'Center Not Found' });
          }

        }

      }
      else {
        res.status(403).send({ 'error': 'User Not Found' });
      }
      res.send({ message: 'rating added' })

    }
    catch (error) { next(error) }
  },

  uploadPicture: async (req, res, next) => {
    try {
      const formidable = require('formidable');
      const form = new formidable.IncomingForm();
      form.parse(req, async function (err, fields, files) {
        if (err) {
          next(err);
        }
        const user = await User.findOne({_id:req.session.user});               
        if (user) {
        cloudinary.v2.uploader.upload(files.image.path, async function (err, result) {
         
            const update = {
              'picture': result.public_id
            }
            await Center.findOneAndUpdate({userId: user._id}, update);
            res.send({status:"success", image:result.public_id});
          
        });
      } else {
        const error = createError(404, 'User not found');
        next(error);
      }
      });
    } catch (error) {
      console.log('uploadPicture error: ', error);
      next(error);
    }
  }
}
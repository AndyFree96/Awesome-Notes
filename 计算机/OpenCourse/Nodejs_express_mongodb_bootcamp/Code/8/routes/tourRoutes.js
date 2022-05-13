const express = require('express');
const tourController = require('../controllers/tourController');

const tourRouter = express.Router();

tourRouter.param('id', tourController.checkID);

tourRouter
  .route('/')
  .get(tourController.getTours)
  .post(tourController.checkBody, tourController.createTours);
tourRouter
  .route('/:id')
  .get(tourController.getTour)
  .patch(tourController.updateTour)
  .delete(tourController.deleteTour);

module.exports = tourRouter;

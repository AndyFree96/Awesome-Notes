const express = require('express');
const tourController = require('../controllers/tourController');

const tourRouter = express.Router();

tourRouter.route('/tour-stat').get(tourController.getTourStats);
tourRouter.route('/monthly-plan/:year').get(tourController.getMonthlyPlan);

tourRouter
  .route('/top-5-cheap')
  .get(tourController.aliasTopTours, tourController.getTours);

tourRouter
  .route('/')
  .get(tourController.getTours)
  .post(tourController.createTours);
tourRouter
  .route('/:id')
  .get(tourController.getTour)
  .patch(tourController.updateTour)
  .delete(tourController.deleteTour);

module.exports = tourRouter;

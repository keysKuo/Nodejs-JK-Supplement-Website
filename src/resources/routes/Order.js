const express = require('express');
const router = express.Router();
const { Controller_Order } = require('../controllers');

router.post('/add', Controller_Order.POST_createOrder);
router.get('/add', Controller_Order.GET_createOrder);

module.exports = router;
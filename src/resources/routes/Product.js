const express = require('express');
const router = express.Router();
const { Controller_Product } = require('../controllers');

router.get('/:slug', Controller_Product.getDetail);

module.exports = router;
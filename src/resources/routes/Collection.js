const express = require('express');
const router = express.Router();
const { Controller_Collection } = require('../controllers');

router.get('/:slug', Controller_Collection.getCollections);

module.exports = router;
const express = require('express');
const router = express.Router();
const { Controller_Account } = require('../controllers');

router.get('/login', Controller_Account.GET_login);
router.post('/login', Controller_Account.POST_login);
router.get('/logout', Controller_Account.GET_logout);
module.exports = router;
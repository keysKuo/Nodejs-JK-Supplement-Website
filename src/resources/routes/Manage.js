const express = require('express');
const router = express.Router();
const { Controller_Manage } = require('../controllers');


router.get('/', (req, res, next) => {
    return res.render('admin/adminHome', {
        layout: 'admin',
        
    });
})

router.get('/list-product', Controller_Manage.GET_listProduct);
router.get('/cart', Controller_Manage.GET_manageCart);
module.exports = router;
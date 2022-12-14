const Router_Collection = require('../routes/Collection');
const Router_Product = require('../routes/Product');
const Router_Order = require('../routes/Order');
const Router_Account = require('../routes/Account');
const Router_Manage = require('../routes/Manage');

function router(app) {
    app.use('/collections', Router_Collection);
    app.use('/products', Router_Product);
    app.use('/order', Router_Order);
    app.use('/account', Router_Account);
    app.use('/manage', Router_Manage);
}

module.exports = router;
const db = require('../../config/db');

const Controller_Manage = {
    // [GET] /manage/list-product
    GET_listProduct: async (req, res, next) => {
        let products = await db.Query(`Select * From Product`)
            .then(products => {
                return products.map(p => {
                    return {
                        pid: p.pid,
                        pname: p.pname,
                        image: p.image,
                        weight: p.weight,
                        price: p.price.toLocaleString('vi-vn',{style:"currency", currency:"vnd"}),
                        strPrice: p.price,
                        stock: p.nImport - p.nExport,
                        slug: p.slug
                    }
                })
            })
        
        
        return res.render('admin/listProduct', {
            layout: 'admin',
            data: products
        })
    },
    
    GET_manageCart: async (req, res, next) => {
        const acc_id = req.session.acc_id;
        let customer = await db.Query(`Select * From Customer Where acc_id = '${acc_id}'`)
            .then(customers => {
                return customers[0];
            })
        return res.render('others/shoppingCart', {
            layout: 'admin',
            account: customer
        })
    }
}

module.exports = Controller_Manage;
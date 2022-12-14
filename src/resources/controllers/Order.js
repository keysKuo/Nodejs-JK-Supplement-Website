const db = require('../../config/db');
const { uuid } = require('uuidv4');

const Controller_Order = {
    // [GET] /order/add
    GET_createOrder: (req, res, next) => {
        req.flash('error', 'Thất bại');
        return res.redirect('/shopping-cart');
    },
    
    // [POST] /order/add
    POST_createOrder: async (req, res, next) => {
        const { fullname, email, phone, address, total, product_list } = req.body;
        if (product_list == "[]") {
            req.flash("error", "Vui lòng thêm sản phẩm vào giỏ");
            return res.redirect("/order/add");
        }
        
        let listProduct = [];
        
        const list = JSON.parse(product_list);
        list.forEach((p) => {
        p = JSON.parse(p);
        const product = {
            pid: p.id,
            name: p.name,
            price: Number(p.price),
            stringPrice: p.stringPrice,
            img: p.img,
            slug: p.slug,
            numberOfUnit: p.numberOfUnit,
        };
        listProduct.push(product);
        });

        //console.log(listProduct)
        let order_id = 'ORD' + uuid().slice(0,7);
        let customer = await db.Query(`Select * From Customer Where name = N'${fullname}' Or phone = '${phone}'`)
            .then(customer => {
                return customer[0];
            })
        if(customer) {
            return await db.Execute(`Insert Into Orders Values ('${order_id}', ${total}, GETDATE(), 'Pending', '${customer.customer_id}')`)
                .then(result => {
                    listProduct.forEach(async product => {
                        await db.Execute(`Insert Into OrderDetail Values ('${order_id}', '${product.pid}', ${product.numberOfUnit}, ${product.price})`)
                    })
                    req.flash("success", "Thành công");
                    return res.redirect('/shopping-cart');
                })
                .catch(err => {
                    req.flash('error', 'Thất bại');
                    return res.redirect('/shopping-cart');
                })
        }else {
            let customer_id = 'C' + uuid().slice(0,7);
            return await db.Execute(`Insert Into Customer Values ('${customer_id}', 'Individual', N'${fullname}', '${phone}', N'${address}', '${email}', N'Khách mới', 0, null)`)
                .then(async result => {
                    return await db.Execute(`Insert Into Orders Values ('${order_id}', ${total}, GETDATE(), 'Pending', '${customer_id}')`)
                        .then(result => {
                            listProduct.forEach(async product => {
                                await db.Execute(`Insert Into OrderDetail Values ('${order_id}', '${product.pid}', ${product.numberOfUnit}, ${product.price})`)
                            })
                            req.flash("success", "Thành công");
                            return res.redirect('/shopping-cart');
                        })
            
                })
                .catch(err => {
                    req.flash('error', 'Thất bại');
                    return res.redirect('/shopping-cart');
                })
        }
        
        // db.Execute(`Insert Into Orders Values ('${order_id}', ${total}, GETDATE(), 'Pending', 'CS0003')`)
        //     .then(result => {
        //         res.json({success: true})
        //     })
        //     .catch(err => {
        //         res.json({success: false, err})
        //     })
    }
}

module.exports = Controller_Order;
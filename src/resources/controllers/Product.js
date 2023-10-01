const db = require('../../config/db');

const Controller_Product = {
    /* This is a function that is used to get the detail of a product. */
    getDetail: async (req, res, next) => {
        const slug = req.params.slug;
        
        return await db.Query(`Select * From Product Where slug = '${slug}'`)
            .then(async product => {
                if (product.length > 0) {
                    
                    let cid = product[0].cid;
                    let pid = product[0].pid;
                    
                    let relatives = await db.Query(`Select Top 2 pname, price, slug, image From Product Where cid = '${cid}' And pid != '${pid}'`)
                        .then(products => {
                            if(products)
                                return products;
                            return []
                        })

                    let stock = product[0].nImport - product[0].nExport;
                    product[0].stock = (stock > 0) ? stock : 'Hết hàng'
                    return res.render('contents/detail', {
                        pageName: product[0].pname,
                        data: product[0],
                        relatives
                    })
                }      
            })
            .catch(err => {
                return res.json({success: false, msg: 'Database not found'});
            })     
    }
}

module.exports = Controller_Product;
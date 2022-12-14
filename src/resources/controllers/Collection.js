const db = require('../../config/db');

const Controller_Collection = {
    getCollections: async (req, res, next) => {
        const slug = req.params.slug;
        return await db.Query(`Select P.*, C.cname  From Product P, Category C Where P.cid = C.cid And C.slug = '${slug}' Order by P.createdAt `)
            .then(products => {
                return res.render('contents/menu', {
                    data: products,
                    pageName: products[0].cname
                })
            })
            .catch(err => {
                return res.json({success: false});
            })
    }
}

module.exports = Controller_Collection;
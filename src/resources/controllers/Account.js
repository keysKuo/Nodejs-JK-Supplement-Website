const db = require('../../config/db');

const Controller_Account = {
    // [GET] /account/login
    GET_login: async (req, res, next) => {
        return res.render('others/login', {
            success: req.flash('success') || '',
            error: req.flash('error') || ''
        })
    },

    // [POST] /account/login
    POST_login: async (req, res, next) => {
        const { username, password } = req.body;

        let account = await db.Query(`Select * From Account Where acc_id = '${username}'`)
            .then(account => {
                return account[0];
            })
            .catch(err => {
                req.flash('error', 'Không tin thấy tài khoản');
                return res.redirect('/account/login');
            })
        
        if(account) {
            if(password == account.password) {
                req.session.acc_id = account.acc_id;
                return res.redirect('/manage')
            }
            else {
                req.flash('error', 'Không đúng mật khẩu');
                return res.redirect('/account/login');
            }
        }

        req.flash('error', 'Không đúng mật khẩu');
        return res.redirect('/account/login');

    },
    GET_logout: (req, res, next) => {
        req.session.destroy();
        return res.redirect('/');
    }
}

module.exports = Controller_Account;
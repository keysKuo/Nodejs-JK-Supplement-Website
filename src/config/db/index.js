// const mongoose = require('mongoose');

// async function connect() {

//     let env = process.env.ENVIRONTMENT == 'production' 
//     ? 'mongodb+srv://sudTech:9999@cluster0.vlcj1l2.mongodb.net/conamsaigon?retryWrites=true&w=majority'
//     : 'mongodb://localhost:27017/haisanco5saigon'
//     try {
//         await mongoose.connect(env, {
//             useNewUrlParser: true,
//             useUnifiedTopology: true,
//         })
//         console.log('Connect to DB successfully')
//     } catch (error) {
//         console.log("Connect failed conamsaigon " + error)
//     }
// }

// module.exports = { connect };

const sql = require('mssql/msnodesqlv8');
require('dotenv').config();

var config = {
    database: 'final_project',
    server: 'DESKTOP-4FUINID\\SQLEXPRESS',
    driver: 'msnodesqlv8',
    options: {
        trustedConnection: true
    }
}

module.exports.Query = (sSQL) => {   
    return new Promise((resolve, reject) => {
        sql.connect(config, err => {
            if (err)    
                reject(err);

            var request = new sql.Request();
            request.query(sSQL, (err, records) => {
                if (err) 
                    reject(err);
        
                sql.close();
                
                if(records)
                    return resolve(records.recordset)
            })  
        });
    })
}

module.exports.Execute = (sSQL) => {
    return new Promise((resolve, reject) => {
        sql.connect(config, err => {
            if (err)    
                reject(err);

            var request = new sql.Request();
            request.query(sSQL, (err, result) => {
                if (err) 
                    reject(err);
        
                sql.close();
                
                if(result)
                    resolve(result)
            })  
        });
    })
}

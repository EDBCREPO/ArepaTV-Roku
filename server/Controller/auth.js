const url = require("url");
const fetch = require("axios");

module.exports = (req,res)=>{
    console.log(req.headers);

    if( req.headers['authentication-token'] ){
        console.log( req.headers['authentication-token'] )
    } else if( req.headers['authentication-user'] ){
        console.log( req.headers['authentication-user'] )
    } else {
        //res.json(404,{ status:"error", payload:"algo salio mal" });
    }

    res.json(200,{ status:"done", payload:"sha256sum" })

}
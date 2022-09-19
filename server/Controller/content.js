const fetch = require("molly-fetch");
const {Buffer} = require("buffer");
const url = require("url")

module.exports = (req,res)=>{

    const raw = Buffer.from(req.query.target,"base64");
    const target = raw.toString().split('|');
    const table = target[0]; 
    const hash = target[1];

    const search = url.format({
        host: `http://localhost:27017/hash`,
        query:{
            table: table, db: "arepatv", target: hash,
            length: 30, offset: req.query.offset || 0
        }
    })

    console.log( search )

    fetch(search).then((response)=>{
        res.json(200,response.data[0])
    }).catch((reject)=>{
        res.send(404,e?.message)
    })

}
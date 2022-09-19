const fetch = require("molly-fetch");
const url = require("url")

module.exports = (req,res)=>{

    const data = ["peliculas","series","novelas"].map(async(x)=>{

        const search = url.format({
            host: `http://localhost:27017/match`,
            query:{
                db: "arepatv", table: x,
                target: req.query.filter || '',
                length: 30, offset: req.query.offset || 0
            }
        })

    })

    console.log(data)
    const response = await fetch(search)
    
    .then((response)=>{
        res.writeHead(200,{'content-type':'text/plain'})
        response.pipe(res)
    }).catch((reject)=>{
        res.writeHead(404,{'content-type':'text/plain'})
        try{ reject.pipe(res) } catch(e) { res.end(e?.message) }
    })

}
const fetch = require("molly-fetch");
const url = require("url")

module.exports = (req,res)=>{

    const type = req.query.filter == '' ? 'list' : 'match';
    const search = url.format({
        host: `http://localhost:27017/${type}`,
        query:{
            db: "arepatv",
            target: req.query.filter || '',
            table: req.query.type || 'peliculas',
            length: 30, offset: req.query.offset || 0
        }
    })

    console.log( search )

    fetch(search,{responseType:'stream'}).then((response)=>{
        res.writeHead(200,{'content-type':'text/plain'})
        response.pipe(res)
    }).catch((reject)=>{
        res.writeHead(404,{'content-type':'text/plain'})
        try{ reject.pipe(res) } catch(e) { res.end(e?.message) }
    })

}
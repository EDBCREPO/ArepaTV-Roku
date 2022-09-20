const fetch = require("axios");
const url = require("url")

module.exports = (req,res)=>{
    return new Promise(async(response,reject)=>{

        const filters = ["peliculas","series","novelas"];
        const suggestion = new Array();

        for( var i in filters ){ const x = filters[i]
            try{
    
                const search = url.format({
                    host: `http://localhost:27017/match`,
                    query:{
                        db: "arepatv", table: x,
                        target: req.query.filter || '',
                        length: 10, offset: req.query.offset || 0
                    }
                });
        
                const {data} = await fetch(search)
                data.map(y=>{ suggestion.push({
                    nombre: `${x} - ${y.nombre}`, 
                    target: `${x}|${y.hash}`,
                })})
    
            } catch(e) { console.log(e) }
        }

        res.json(200,suggestion);

    })
}
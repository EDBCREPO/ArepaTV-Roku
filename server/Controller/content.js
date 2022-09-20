const {Buffer} = require("buffer");
const fetch = require("axios");
const url = require("url")

function parseMagnet( hash,magnet,type ){
    if( typeof magnet == 'string' ){
        return `/play?hash=${hash}&type=${type}`;
    } else {
        return magnet.map((x,i)=>{ return x.map((y,j)=>{
            y.src = `/play?hash=${hash}&type=${type}$cap=${j}&tmp=${i}`;
            return y;
        })})
    }
}

module.exports = (req,res)=>{

    const raw = Buffer.from(req.query.target,"base64");
    const target = raw.toString().split('|');
    const table = target[0] || "peliculas"; 
    const hash = target[1];

    const search = url.format({ host: `http://localhost:27017/hash`,
        query:{ table: table, db: "arepatv", target: hash }
    });//console.log( search )

    fetch(search).then((response)=>{
        
        magnet = parseMagnet(
            response.data[0].hash,
            response.data[0].magnet,table
        );  response.data[0].magnet = magnet;
        res.json(200,response.data[0])

    }).catch((reject)=>{
        console.log( reject.data )
        res.send(404,reject.data)
    })

}
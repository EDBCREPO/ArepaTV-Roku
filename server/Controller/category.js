module.exports = (req,res)=>{
    res.json(200,{
        type: ["peliculas","novelas","series"],
        category: ["accion","terror","suspenso","animacion","familia"]
    })
}
sub init() : eventMain() : main() : end sub

function main() as Void

    m.loading = false
    movieContentRequest()

end function

function movieContentRequest() as Void
    if m.loading = false : m.loading = true

    query = m.global.target : Buffer = createObject("roByteArray")
    buff = Buffer.FromAsciiString( query ) : query = Buffer.ToBase64String()

    uri = m.global.ip+"/content?" : uri+= "&target="+query

    m.fetch = createObject("roSGNode","fetchApi")
    m.fetch.observeField("response","showMovieContent")
    m.fetch.setField("headers",{
        "authetication-token": m.global.auth
    }) : m.fetch.setField("uri",uri)
    m.fetch.functionName = "main"
    m.fetch.control = "RUN"
    
    end if
end function

function showMovieContent() as Void
    json = ParseJson(m.fetch.response) : print json 
    m.top.findNode("movie_poster").uri = json.imagen
    m.top.findNode("movie_nombre").title = json.nombre
    m.top.findNode("movie_background").uri = json.poster
    m.top.findNode("movie_category").text = "categorias: "
    m.top.findNode("movie_descricion").text = json.descripcion

    for each item in json.categoria
        m.top.findNode("movie_category").text += item+" | "         
    end for

end function
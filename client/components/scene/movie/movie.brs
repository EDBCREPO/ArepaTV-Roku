sub init() : eventMain() : main() : end sub

function main() as Void
    m.loading = false : movieContentRequest()
    m.top.observeField("uri","playMovieRequest")
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
    m.top.findNode("movie_background").uri = json.poster
    m.top.findNode("movie_category").text = "categorias: "
    m.top.findNode("movie_descricion").text = json.descripcion

    m.top.findNode("movie_nombre").text = json.nombre
    m.top.findNode("movie_bar").title = json.nombre
    m.top.findNode("movie_nombre").font.size = 40

    for each item in json.categoria
        m.top.findNode("movie_category").text += item+" | "         
    end for

    if type(json.magnet) = "String"
        m.top.pelicula = json.magnet
    else
        m.top.temporada = json.magnet
    end if

    m.loading = false
end function

function playMovieRequest() as Void
    if m.loading = false : m.loading = true

        uri = m.global.ip+m.top.uri
        print "echo"
        print uri
    
        m.fetch = createObject("roSGNode","fetchApi")
        m.fetch.observeField("response","playMovieContent")
        m.fetch.setField("headers",{
            "authetication-token": m.global.auth
        }) : m.fetch.setField("uri",uri)
        m.fetch.functionName = "main"
        m.fetch.control = "RUN"
        
    end if
end function

function playMovieContent() as Void

    content = createObject("roSGNode","ContentNode")
    video = m.top.findNode("video_player")
    json = ParseJson( m.fetch.response )
    m.top.uri = "" : m.loading = false
    
    content.streamformat = json[0].type
    content.url = json[0].file
   'content.title = "none"

    m.currentID = "video_player"
    video.content = content
    video.control = "play"
    video.visible = true
    video.setFocus(true)

end function
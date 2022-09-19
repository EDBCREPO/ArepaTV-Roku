sub init() : eventMain() : main() : end sub

function main() as Void

    m.loading = false : loadMovies()
    m.global.observeField("type","loadMovies")
    m.global.observeField("filter","loadMovies")
    m.global.observeField("offset","movieRequest")

    catList = m.top.findNode("category_list_container")
    catlist.getChild(1).observeField("itemSelected","typeLoader")
    catlist.getChild(2).observeField("itemSelected","categoryLoader")

end function 

'-------------------------------------------------------------------------------------------------------------'

function typeLoader() as Void
    catList = m.top.findNode("category_list_container")
    el = catlist.getChild(1) : index = el.itemSelected
    m.global.setFields({ filter: "",
        type: el.content.getChild(index).title, 
    })
end function

function categoryLoader() as Void
    catList = m.top.findNode("category_list_container")
    el = catlist.getChild(2) : index = el.itemSelected
    m.global.setFields({
        filter: el.content.getChild(index).title, 
    })
end function

'-------------------------------------------------------------------------------------------------------------'

function loadMovies() as Void
    m.movies = createObject("roAssociativeArray")
    m.movies.list = m.top.findNode("movie_container")
    m.movies.content = createObject("roSGNode","ContentNode")
    m.movies.list.removeChildIndex(0) : m.movies.list.content = m.movies.content
    initState() : categoryRequest() : movieRequest()
end function

function movieRequest() as Void
    if m.loading = false : m.loading = true

    offset = mid(strI( m.movies.content.getChildCount() ),2)

    uri = m.global.ip+"/movies?" :  uri+= "offset="+offset 
    uri+= "&filter="+m.global.filter : uri+= "&type="+m.global.type
    print uri

    m.fetch = createObject("roSGNode","fetchApi")
    m.fetch.observeField("response","showMovies")
    m.fetch.setField("headers",{
        "authetication-token": m.global.auth
    }) : m.fetch.setField("uri",uri)
    m.fetch.functionName = "main"
    m.fetch.control = "RUN"
    
    end if
end function

function categoryRequest() as Void
    m.catfetch = createObject("roSGNode","fetchApi")
    m.catfetch.observeField("response","showCategories")
    m.catfetch.setField("uri",m.global.ip+"/category")
    m.catfetch.functionName = "main"
    m.catfetch.control = "RUN"
end function

function showCategories() as Void
    categories = ParseJson( m.catfetch.response )
    if categories <> invalid

        cattype = createObject("roSGNode","ContentNode")
        for each item in categories.type
            node = createObject("roSGNode","ContentNode")
            node.title = item : cattype.appendChild( node )
        end for : m.top.findNode("type_list").content = cattype

        catcat = createObject("roSGNode","ContentNode")
        for each item in categories.category
            node = createObject("roSGNode","ContentNode")
            node.title = item : catcat.appendChild( node )
        end for : m.top.findNode("category_list").content = catcat

    end if
end function

function showMovies() as Void
    movies = ParseJson( m.fetch.response )
    if movies <> invalid
        for each item in movies
            node = createObject("roSGNode","ContentNode")
            node.SDGRIDPOSTERURL = item.imagen : node.HDGRIDPOSTERURL = item.imagen
            node.addFields({ hash: item.hash }) : node.title = item.nombre
            m.movies.content.appendChild( node )
        end for : m.loading = false
    end if 
end function 
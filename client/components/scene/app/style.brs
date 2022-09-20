
function initState() as Void
    if m.global.type = "" or m.global.type = invalid then m.global.type = "peliculas" 
    m.top.findNode("category_list_container").visible = false
    m.top.findNode("search_layout").removeChildIndex(0)
    m.top.findNode("movie_layout").removeChildIndex(0)
    m.top.findNode("movie_container").setFocus(true)
    m.index = 1 : loadNewElement()
end function

'-------------------------------------------------------------------------------------------------------------'

function loadNewElement() as Void

    m.currentID = m.current[m.index]
    DarkRegex = CreateObject("roRegex", "dark", "gi")
    LightRegex = CreateObject("roRegex", "light", "gi")
    new = m.top.findNode(m.currentID) : new.setFocus(true)

    for each item in m.current
        try 
            if left(item,3) = "btn"  
                old = m.top.findNode( item )
                old.getChild(0).color = "0xFFFFFF00"
                old.getChild(1).uri = DarkRegex.replace(old.getChild(1).uri,"light")
            end if
        catch e : end try        
    end for

    try
        new.getChild(1).uri = LightRegex.replace(new.getChild(1).uri,"dark")
        new.getChild(0).color = "0xFFFFFFFF"
    catch e : end try

end function

'-------------------------------------------------------------------------------------------------------------'

function showCategorySelector() as Void
    m.currentID = "category_list_container"
    m.catlist = m.top.findNode(m.currentID) 
    m.catlist.getChild(1).setFocus(true)
    m.catlist.getChild(1).jumpToItem = 0
    m.catlist.getChild(2).jumpToItem = 0
    m.catlist.visible = true
end function

function hideCategorySelector() as Void
    m.currentID = "btn_menu" : m.catlist.visible = false
    m.top.findNode(m.currentID).setFocus(true)
end function

function showSearchLayout() as Void
    el = m.top.findNode("search_layout")
    m.layout = createObject("roSGNode","searchScene") 
    el.appendChild(m.layout) : m.layout.observeField("visible","eventMain")
end function

function showMovieContent() as Void
    if m.loading = false : m.loading = true 
        m.layout = createObject("roSGNode","movieScene")
        m.global.target = "" : el = m.top.findNode("movie_layout")
        el.appendChild(m.layout) : m.layout.observeField("visible","eventMain")
        sleep(300) : m.loading = false
    end if
end function


function eventMain() as Void
    m.current = [
        "category_list_container"
        "movie_container"
        "btn_search",
        "btn_home",
        "btn_menu",
        "btn_cls",
    ] : m.index = 1
        m.top.findNode("movie_layout").removeChildIndex(0)
        m.currentID = m.current[m.index] : loadNewElement()
end function

function keyEvent( event as Object )
    if m.top.visible = true
        el1 = m.top.findNode("search_layout").getChild(0)
        el2 = m.top.findNode("movie_layout").getChild(0)
        if el1 <> invalid or el2 <> invalid
            m.layout.callFunc("keyEvent",{ key: event.key, pressed: event.pressed })
        else if m.currentID <> "category_list_container"
            mainScreenEvent(event)
        else : categoryListEvent(event) : end if
    end if
end function 

function categoryListEvent( event as Object ) as Void
    if event.key = "up"
        m.catlist.getChild(1).setFocus(true)
    else if event.key = "down"
        m.catlist.getChild(2).setFocus(true)
    else
        hideCategorySelector()
    end if
end function 

function mainScreenEvent( event as Object ) as Void

    if m.index = 1
        if event.key = "left" then m.index++
        if event.key = "down" then m.global.offset++
    end if 

    if m.index > 1 and m.index < 6

        if event.key = "up" then m.index--
        if event.key = "down" then m.index++

        if m.index <= 1 then m.index = 5
        if m.index >= 6 then m.index = 2

        if event.key = "right" then m.index = 1

    end if 

    if event.key = "options"
        showCategorySelector()
    else if event.key = "replay"
        reloadPage()
    else if event.key = "OK"
        selectedElement()
    else 
        loadNewElement()
    end if

end function

function selectedElement() as Void
    if m.currentID = "btn_cls"
        m.top.visible = false
    else if m.currentID = "btn_menu"
        showCategorySelector()
    else if m.currentID = "btn_home"
        reloadPage()
    else if m.currentID = "btn_search"
        el = m.top.findNode("search_layout")
        m.layout = createObject("roSGNode","searchScene") 
        el.appendChild(m.layout) : m.layout.observeField("visible","eventMain")
    end if
end function

function reloadPage() as Void
    m.global.filter = "" : loadMovies()
end function
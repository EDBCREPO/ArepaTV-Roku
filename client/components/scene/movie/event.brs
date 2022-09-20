function eventMain() as Void
    m.current = [
        "btn_play",
        "btn_back"
    ] : m.index = 0 : loadNewElement()
    m.top.findNode("video_player").control = "stop"
    m.top.findNode("Chapter_list").visible = false
    m.top.findNode("video_player").visible = false
end function

function keyEvent( event as Object )
    if m.top.visible = true

        if m.currentID <> "video_player"

            if event.key = "left" then m.index--
            if event.key = "right" then m.index++
            if event.key = "back" then m.top.visible = false
    
            if event.key = "OK"
                if m.currentID = "btn_play" then loadMoviePlayer()
                if m.currentID = "btn_back" then m.top.visible = false
            end if 

            loadNewElement()

        else
            if event.key = "back" then hideVideoPlayer()
        end if

    end if
end function 

function loadNewElement() as Void

    if m.index < 0 then m.index = m.current.count()-1
    if m.index >= m.current.count() then m.index = 0
    m.currentID = m.current[m.index]

    for each item in m.current
        try 
            el = m.top.findNode(item)
            el.getChild(0).color = "0x00000000"
            el.getChild(1).color = "0xFFFFFF"
        catch e : end try        
    end for

    m.top.findNode(m.currentID).setFocus(true)
    m.top.findNode(m.currentID).getChild(0).color = "0xFFFFFF"
    m.top.findNode(m.currentID).getChild(1).color = "0x000000"

end function

function hideVideoPlayer() as Void
    video = m.top.findNode("video_player")
    video.control = "stop"
    video.visible = false
    loadNewElement()
end function

function loadMoviePlayer() as Void
    if m.top.pelicula <> ""
        m.top.uri = m.top.pelicula
        print m.top.uri
    else
        showChapterLayout()
    end if 
end function

function showChapterLayout() as Void
end function
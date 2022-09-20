function mainEvent() as Void

    m.current = [
        "search_list",
        "search_keyboard",
        "search_button",
    ] : m.index = 1 : focusNewObject() 

end function

function keyEvent( event as Object )
    if m.top.visible = true

        if m.index <> 2
            if event.key = "left" then m.index++
            if event.key = "right" then m.index--
            focusNewObject()
        else 
            if event.key = "up" then m.index=1
            if event.key = "OK" then searchEvent() 
            focusNewObject() 
        end if

        if event.key = "down" then m.index=2
        if event.key = "back" then hideScene() 

    end if
end function 

function hideScene() as Void
    m.top.visible = false
end function

function searchEvent() as Void
    keyboard = m.top.findNode("search_keyboard")
    m.global.filter   = keyboard.textEditBox.text
    m.global.filtered = keyboard.textEditBox.text
end function

function focusNewObject() as Void

    if m.index <> 2

        m.top.findNode("search_button").getChild(0).color="0xFFFFFF50"
        m.top.findNode("search_button").getChild(1).color="0xFFFFFF"

        if m.index < 0 then m.index = 1
        if m.index > 1 then m.index = 0

        node = m.current[m.index]
        el = m.top.findNode(node)
        el.setFocus(true)

    else
        m.top.findNode("search_button").getChild(0).color="0xFFFFFF"
        m.top.findNode("search_button").getChild(1).color="0x000000"
        m.top.findNode("search_button").setFocuse(true)
    end if

end function
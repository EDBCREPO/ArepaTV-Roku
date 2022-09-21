function mainEvent() as Void

    m.current = [
        "search_keyboard",
        "search_list"
    ] : m.index = 0 : focusNewObject() 

end function

function keyEvent( event as Object )
    if m.top.visible = true
        if event.key = "back" then hideScene() 
        if event.key = "right" then m.index--
        if event.key = "left" then m.index++
        focusNewObject()
    end if
end function 

function hideScene() as Void
    m.top.visible = false
end function

function focusNewObject() as Void

    if m.index < 0 then m.index = m.current.count() - 1
    if m.index >= m.current.count() then m.index = 0

    node = m.current[m.index]
    el = m.top.findNode(node)
    el.setFocus(true)

end function
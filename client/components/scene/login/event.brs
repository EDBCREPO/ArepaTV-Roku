
function eventMain() as Void
    m.elementList = [
        "login_user",
        "login_pass",
        "login_sign",
    ] : m.index = 0
end function 

function keyEvent( event as Object )
    if m.top.visible = true

        if m.inputEvent <> true
            if event.key = "up" then m.index -= 1
            if event.key = "down" then m.index += 1
        end if : changeCurrent()

        if event.key = "OK"
            if m.current.id <> "login_sign"
                m.top.findNode( m.current.id+"_text" ).text = "" : inputBoard()
            end if : if m.current.id = "login_sign" then login()
        end if 

    end if
end function 

'-------------------------------------------------------------------------------------------------------------'

function inputBoard() as Void
    m.inputEvent = true
    keyboard = m.top.findNode("login_key")
    m.top.findNode("keyboard_container").visible = true
    keyboard.textEditBox.observeField("text","onKeyChange")
    keyboard.textEditBox.text = "" : keyboard.setFocus(true)
end function

function onKeyChange() as Void
    keyText = m.top.findNode("login_key").textEditBox.text
    label = m.top.findNode( m.elementList[m.index]+"_text" )
    label.text = keyText
end function

'-------------------------------------------------------------------------------------------------------------'

function changeCurrent() as Void

    m.current.opacity = 1 : m.inputEvent = false

    if m.index >= m.elementList.Count() then m.index = 0
    if m.index < 0 then m.index = m.elementList.Count()-1

    m.current = m.top.findNode( m.elementList[m.index] )
    m.top.findNode("keyboard_container").visible = false
    m.current.setFocus(true) : m.current.opacity = 0.5

end function
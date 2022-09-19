
sub Main() : init() : End sub

''-------------------------------------------------------------------------------------------''

function init() as Void

    '' creating screen ''
    m.port = CreateObject("roMessagePort")
    screen = CreateObject("roSGScreen")
    screen.setMessagePort(m.port)

    '' creating global variable ''
    m.global = screen.getGlobalNode()  
    m.global.addFields({
        auth: "", ip:"http://192.168.101.8:3000",
        type: "peliculas", filter: "", offset:0
    }) : print m.global

    '' creating scene ''
    m.scene = screen.CreateScene("main")
    screen.show() : m.scene.setFocus(true)
    m.scene.observeField("focusedChild", m.port)
    m.scene.ObserveField("selectedListItem", m.port)

    '' loading content from webServer ''
    ScreenEventHandler()
    
End function

''-------------------------------------------------------------------------------------------''

function ScreenEventHandler() as Void
    while true : msg=wait(0,m.port) 
        if type(msg) = "roSGNodeEvent"
        end if
    End while
end function

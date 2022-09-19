sub init() : main() : end sub

'-------------------------------------------------------------------------------------------------------------'
    
function main() as Void
    m.auth = createObject("roSGNode","registrationApi")
    m.auth.observeField("status","loginLayout")
    m.auth.functionName = "GetAuthData"
    m.auth.control = "RUN"
end function 

'-------------------------------------------------------------------------------------------------------------'

function loginLayout() as Void

    if m.fetch <> invalid ''  cargando escena de login ''
        m.json = ParseJson(m.fetch.response)
        if m.json.status = "error" or m.auth.status = "error" 
            m.loginScene = createObject("roSGNode","loginScene")
            m.top.findNode("login_layout").appendChild(m.loginScene)
            m.loginScene.observeField("visible","appLayout")
        else : appLayout() : end if
    else 
        m.fetch = createObject("roSGNode","fetchApi")
        m.fetch.setField("headers",{ "authetication-token": m.global.auth })
        m.fetch.observeField("response","loginLayout")
        m.fetch.setField("uri",m.global.ip+"/auth") 
        m.fetch.functionName = "main"
        m.fetch.control = "RUN" 
    end if

end function

'-------------------------------------------------------------------------------------------------------------'

function appLayout() as Void
    m.global.setField("auth",m.json.payload)
    m.appScene = createObject("roSGNode","appScene")
    m.appScene.observeField("visible","logoutLayout")
    m.top.findNode("app_layout").appendChild(m.appScene)
end function

function logoutLayout() as Void
    if m.appScene.visible = false
        auth = createObject("roSGNode","registrationApi")
        auth.observeField("status","loginLayout")
        auth.functionName = "removeAuthData"
        auth.control = "RUN" : sleep(1000)
        main()
    end if
end function

'-------------------------------------------------------------------------------------------------------------'

function onKeyEvent( key as string, pressed as Boolean ) as Boolean
    if pressed <> true return false
        if m.appScene <> invalid then m.appScene.callFunc("keyEvent",{ key: key, pressed: pressed })
        if m.loginScene <> invalid then m.loginScene.callFunc("keyEvent",{ key: key, pressed: pressed })
    return true
end function 

'-------------------------------------------------------------------------------------------------------------'
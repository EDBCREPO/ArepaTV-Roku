sub init() : eventMain() : main() : end sub

'-------------------------------------------------------------------------------------------------------------'

function main() as Void
    m.current = m.top.findNode("login_user")
    m.current.setFocus(true)
    m.current.opacity = 0.5
end function 

'-------------------------------------------------------------------------------------------------------------'

function login() as Void

    Buffer = createObject("roByteArray")
    authetication = m.top.findNode( "login_user_text" ).text+"|"
    authetication+= m.top.findNode( "login_pass_text" ).text+"|"

    Buffer.FromAsciiString( authetication )
    authetication = Buffer.ToBase64String()

    m.fetch = createObject("roSGNode", "fetchApi")
    m.fetch.setField("headers",{ "authetication-user": authetication })
    m.fetch.setField("uri", m.global.ip+"/auth")
    m.fetch.observeField("response", "response")
    m.fetch.functionName = "main"
    m.fetch.control = "RUN"

end function

function response() as Void
    json = ParseJSON( m.fetch.response )
    if json.status = "error"
        m.top.findNode("login_error_border").visible = true
        m.top.findNode("login_error_text").text = json.payload
        m.top.findNode("login_user_text").text = ""
        m.top.findNode("login_pass_text").text = ""
    else
        m.auth = createObject("roSGNode","registrationApi")
        m.auth.setField("hash",json.payload)
        m.auth.functionName = "SetAuthData"
        m.global.auth = json.payload
        m.auth.control = "RUN"
        m.top.visible = false '' change to the next layout ''
    end if
end function 

'-------------------------------------------------------------------------------------------------------------'

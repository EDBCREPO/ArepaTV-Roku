sub init() : mainEvent() : main() : end sub

function main() as Void
    m.keyBoard = m.top.findNode("search_keyboard")
    m.textBox = m.keyBoard.textEditBox
    m.textBox.observeField("text","suggestion")
    m.keyBoard.setFocus(true)
end function

function suggestion() as Void

    query = m.global.ip+"/suggest?filter="+m.textBox.text
    m.fetch = createObject("roSGNode","fetchApi")
    m.fetch.observeField("response","addSuggestions")
    m.fetch.setField("headers",{
        "authetication-token": m.global.auth
    }) : m.fetch.setField("uri",query)
    m.fetch.functionName = "main"
    m.fetch.control = "RUN"
    print query

end function

function addSuggestions() as Void
    content = createObject("roSGNode","ContentNode")
    response = ParseJson(m.fetch.response)
    el = m.top.findNode("search_list")
    for each item in response
        node = createObject("roSGNode","ContentNode")
        node.addFields({
            title: item.nombre,
            type: item.tipo
        })
    end for : el.content = content
end function
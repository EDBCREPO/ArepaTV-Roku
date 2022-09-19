sub init() : mainEvent() : main() : end sub

function main() as Void

    m.keyBoard = m.top.findNode("search_keyboard")
    m.textBox = m.keyBoard.textEditBox : m.loading = false
    m.list = m.top.findNode("search_list")
    m.keyBoard.setFocus(true)
    suggestion()

    m.list.observeField("itemSelected","itemSelected")
    m.textBox.observeField("text","suggestion")

end function

function suggestion() as Void
    if m.loading = false : m.loading = true
        query = m.global.ip+"/suggest?filter="+m.textBox.text
        m.fetch = createObject("roSGNode","fetchApi")
        m.fetch.observeField("response","addSuggestions")
        m.fetch.setField("headers",{
            "authetication-token": m.global.auth
        }) : m.fetch.setField("uri",query)
        m.fetch.functionName = "main"
        m.fetch.control = "RUN"
        print query
    end if
end function

function itemSelected() as Void
    index = m.list.itemSelected
    node = m.list.content.getChild(index)
    m.global.setFields({ target: node.target })
end function

function addSuggestions() as Void
    response = ParseJson(m.fetch.response)
    m.list.removeChildIndex(0)
    if response <> invalid
        content = createObject("roSGNode","ContentNode")
        for each item in response
            node = createObject("roSGNode","ContentNode")
            node.addFields({ target: item.target })
            content.appendChild(node)
            node.title = item.nombre
        end for : m.list.content = content
    end if : m.loading = false
end function
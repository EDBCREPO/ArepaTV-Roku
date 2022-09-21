
function movieSelectorMain() as Void
    m.chapter_list = m.top.findNode("chapter_content_list")
    m.chapter_list.observeField("itemFocused","itemFocused")
    m.chapter_list.observeField("itemSelected","itemSelected")
end function

function itemFocused() as Void
    barTitle = m.top.findNode("movie_temp")
    temporada = m.chapter_list.currFocusRow+1
    barTitle.title = "Temporada"+StrI(temporada)
end function

function itemSelected() as Void
    
    row = m.chapter_list.currFocusRow : if row < 0 then row = 0 
    col = m.chapter_list.currFocusColumn : if col < 0 then col = 0

    content = m.chapter_list.content.getChild(row).getChild(col)
    m.top.uri = content.src

end function
sub init()
    m.top.functionName = "getcontent"
end sub

sub getcontent()

    content = createObject("roSGNode", "ContentNode")

    contentxml = createObject("roXMLElement")

    readInternet = createObject("roUrlTransfer")
    readInternet.setUrl(m.top.contenturi)
    
    contentxml.parse(readInternet.GetToString())

    if contentxml.getName()="Content"
        for each item in contentxml.GetNamedElements("item")
            itemcontent = content.createChild("ContentNode")
            itemcontent.setFields(item.getAttributes())
        end for
    end if

    m.top.content = content
end sub
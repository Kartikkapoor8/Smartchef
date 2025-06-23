' get_channel_list.brs for Cooking App
' Builds separate lists for "pasta" and "pizza"

sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    ' Get the requested category from the parent
    category = LCase(m.top.category)

    con = CreateObject("roSGNode", "ContentNode")
    
    if category = "pasta" then
        
        dish = con.CreateChild("ContentNode")
        dish.title = "Pasta Carbonara"
        dish.url = "https://cooking-app-videos-123.web.app/pasta.mp4"
        dish.streamFormat = "mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Pasta alla Vodka"
        dish.url = "pkg:/videos/pasta.mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Pasta alla Gricia "
        dish.url = "pkg:/videos/pasta.mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Pasta Puttanesca "
        dish.url = "pkg:/videos/pasta.mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Pasta al Limone"
        dish.url = "pkg:/videos/pasta.mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Pasta Pista"
        dish.url = "pkg:/videos/pasta.mp4"

    else if category = "pizza" then
        dish = con.CreateChild("ContentNode")
        dish.title = "Margherita Pizza"
        dish.url = "https://cooking-app-videos-123.web.app/Pizza.mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Paneer Tikka Pizza"
        dish.url = "pkg:/videos/pasta.mp4"
       
        dish = con.CreateChild("ContentNode")
        dish.title = "Pizza Bianca"
        dish.url = "pkg:/videos/pasta.mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Pizza Ortolana"
        dish.url = "pkg:/videos/pasta.mp4"
        
        dish = con.CreateChild("ContentNode")
        dish.title = "Pizza Capricciosa "
        dish.url = "pkg:/videos/pasta.mp4"

        dish = con.CreateChild("ContentNode")
        dish.title = "Pizza al Tartufo"
        dish.url = "pkg:/videos/pasta.mp4"
        

    end if

    m.top.content = con
end sub



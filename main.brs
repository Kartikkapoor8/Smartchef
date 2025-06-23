' Main entry point for the Cooking App

sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    m.global = screen.getGlobalNode()
    ' Add global fields here if needed in future
    ' m.global.addFields({ feedurl: "pkg:/videos/pasta.mp4" })

    scene = screen.CreateScene("MainScene")
    screen.show()

    while true
        msg = wait(0, m.port)
        if type(msg) = "roSGScreenEvent" and msg.isScreenClosed()
            return
        end if
    end while
end sub

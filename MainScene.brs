sub init()
    ' Typing Animation Setup
    m.feedbackButton = m.top.FindNode("feedbackButton")
    m.feedbackTextFull = "Give Feedback"
    m.feedbackCharIndex = 1

    m.typingTimer = createObject("roSGNode", "Timer")
    m.typingTimer.duration = 0.1
    m.typingTimer.repeat = true
    m.typingTimer.observeField("fire", "onTypingTick")
    m.top.appendChild(m.typingTimer)
    m.typingTimer.control = "start"

    ' UI + Content Setup
    m.top.backgroundURI = "pkg:/images/background_lightbeige.jpg"

    m.get_channel_list = m.top.FindNode("get_channel_list")
    m.get_channel_list.ObserveField("content", "SetContent")

    m.list = m.top.FindNode("list")
    m.list.ObserveField("itemSelected", "setChannel")

    m.video = m.top.FindNode("Video")
    m.video.ObserveField("state", "checkState")

    m.ingredientLabel = m.top.FindNode("ingredients")
    m.ingredientLabel.visible = false

    m.state = "search"
    showdialog()
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if not press return result

    if key = "back" then
        if m.state = "video" then
            m.video.control = "stop"
            m.video.translation = [800, 100]
            m.video.width = 960
            m.video.height = 540
            m.ingredientLabel.visible = false
            m.list.SetFocus(true)
            m.state = "list"
            result = true

        else if m.state = "list" then
            showdialog()
            m.ingredientLabel.visible = false
            m.state = "search"
            result = true
        end if

    else if key = "left" then
        m.list.SetFocus(true)
        m.video.translation = [800, 100]
        m.video.width = 960
        m.video.height = 540
        result = true

    else if key = "right" then
        m.list.SetFocus(false)
        m.video.translation = [0, 0]
        m.video.width = 0
        m.video.height = 0
        result = true
    end if

    return result
end function

sub onTypingTick()
    if m.feedbackCharIndex <= len(m.feedbackTextFull) then
        m.feedbackButton.text = left(m.feedbackTextFull, m.feedbackCharIndex)
        m.feedbackCharIndex++
    else
        m.typingTimer.control = "stop"
    end if
end sub

sub checkState()
    if m.video.state = "error" then
        dialog = CreateObject("roSGNode", "Dialog")
        dialog.title = "Video Error"
        dialog.message = m.video.errorMsg
        m.top.dialog = dialog
    end if
end sub

sub SetContent()
    m.list.content = m.get_channel_list.content
    m.list.SetFocus(true)
    m.state = "list"
end sub

sub setChannel()
    if m.list.content <> invalid and m.list.content.getChildCount() > 0 then
        dish = m.list.content.GetChild(0)
        dish.streamFormat = "mp4"
        m.video.content = dish
        m.video.control = "play"

        m.ingredientLabel.text = "Ingredients:\nPasta\nGarlic\nOlive Oil\nSalt\nPepper"
        m.ingredientLabel.visible = true

        m.state = "video"
    end if
end sub

sub showdialog()
    print ">>> ENTERING DISH SELECTION DIALOG <<<"

    keyboarddialog = CreateObject("roSGNode", "KeyboardDialog")
    keyboarddialog.backgroundColor = "#000000"
    keyboarddialog.title = "Enter Dish Name:"
    keyboarddialog.buttons = ["OK", "Demo Dish"]
    keyboarddialog.optionsDialog = true

    m.top.dialog = keyboarddialog
    m.top.dialog.text = ""
    m.top.dialog.keyboard.textEditBox.cursorPosition = 0
    m.top.dialog.keyboard.textEditBox.maxTextLength = 300

    keyboarddialog.ObserveFieldScoped("buttonSelected", "onKeyPress")
end sub

sub onKeyPress()
    if m.top.dialog.buttonSelected = 0 or m.top.dialog.buttonSelected = 1 then
        userInput = LCase(m.top.dialog.text)

        if userInput = "pasta" or userInput = "pizza" then
            m.get_channel_list.category = userInput
            m.get_channel_list.control = "RUN"
            sleep(300)

            if m.get_channel_list.content <> invalid then
                m.list.content = m.get_channel_list.content
                m.state = "list"
            end if
        else
            print "Dish not recognized: " + userInput
            dialog = CreateObject("roSGNode", "Dialog")
            dialog.title = "Dish Not Found"
            dialog.message = "Try typing 'pasta' or 'pizza'."
            m.top.dialog = dialog
        end if

        m.top.dialog.close = true
    end if
end sub

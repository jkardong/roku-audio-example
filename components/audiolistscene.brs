sub init()
    ? "testing"

    m.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"

      m.audiolist = m.top.findNode("AllTracksList")

      m.audiolist.observeField("itemFocused", "setaudio") 'calls setaudio() and sets XML to audio player
      m.audiolist.observeField("itemSelected", "playaudio") 'calls playaudio() stops current stream and plays URI from selected XML node

      m.audio = createObject("RoSGNode", "Audio")

      m.audio.observeField("state", "controlaudioplay") 'call controlaudioplay() 

      m.readAudioContentTask = createObject("RoSGNode", "ContentReader") 'create new contentreader.xml
      m.readAudioContentTask.observeField("content", "showaudiolist") 'watch contentreader.xml interface
      m.readAudioContentTask.contenturi = "http://www.sdktestinglab.com/Tutorial/content/audiocontent.xml" 'set url in contentreader.xml
      'm.readAudioContentTask.contenturi = "pkg:/data/feed.xml"
      m.readAudioContentTask.control = "RUN" 
    end sub

    sub showaudiolist()
      m.audiolist.content = m.readAudioContentTask.content
      m.audiolist.setFocus(true)
    end sub

    sub setaudio()
      audiocontent = m.audiolist.content.getChild(m.audiolist.itemFocused)
      ? "Set Audio"
      ? audiocontent
      m.audio.content = audiocontent
    end sub

    sub playaudio()
      m.audio.control = "stop" 'stop previous stream
      m.audio.control = "none" 'reset
      m.audio.control = "play" 'play new stream
    end sub

    sub controlaudioplay()
      if (m.audio.state = "finished") 
        m.audio.control = "stop"
        m.audio.control = "none"
      end if
    end sub

    function onKeyEvent(key as String,press as Boolean) as Boolean
      if press then
        if key = "back"
          if (m.audio.state = "playing")
            m.audio.control = "stop"

            return true
          end if
        end if
      end if

      return false
    end function

$(document).ready ->
  app.init()

app =
  current_section: "menu"

  init: ->
    @bind_events()
    @play_sound "8bit"

  bind_events: ->
    $(document).on "click", ".btn-switch-section", (e) ->
      e.preventDefault()
      app.switch_section $(this).data "section"

  switch_section: (section) ->
    $("." + this.current_section).hide()
    $("." + section).show()
    this.current_section = section

  play_sound: (sound) ->
    audioElement = document.createElement "audio"
    audioElement.setAttribute "src", "assets/sounds/" + sound + ".mp3"
    audioElement.setAttribute "type", "audio/mp3"
    audioElement.setAttribute "autoplay", "autoplay"
    audioElement.setAttribute "loop", "true"

    audioElement.addEventListener "load", (->
      audioElement.play()
    ), true
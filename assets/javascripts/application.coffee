$(document).ready ->
  app.init()

app =
  current_section: "menu"
  current_level: 1
  starting_speed: 5

  init: ->
    @bind_events()
    @play_sound "8bit"

  bind_events: ->
    $(document).on "click", ".btn-switch-section", (e) ->
      e.preventDefault()
      app.switch_section $(this).data "section"

    $(document).on "click", ".btn-number", (e) ->
      e.preventDefault()
      app.remove_numbers $(this).text()

  switch_section: (section) ->
    $("." + @current_section).hide()
    $("." + section).show()
    @current_section = section

    switch @current_section
      when "game"
        @prepare_game()

  prepare_game: ->
    @current_level = 1
    $(".level span").text @current_level
    $(".display").html("")
    @start_game()

  start_game: ->
    @add_random_number()

  remove_numbers: (number) ->
    current_display = $(".display").text()
    regex = new RegExp number, "g"
    # matches = current_display.match(regex)
    # console.log matches.length()
    new_display = current_display.replace(regex, "")
    $(".display").text(new_display)

  add_random_number: ->
    # alert $(".display").length()
    # if ($(".display").length() < 9) {
    $(".display").append(@get_random_number())
    current_speed = (@starting_speed * 1000) / @current_level
    setTimeout (->
      app.add_random_number()
    ), current_speed
    # } else {
    #   alert "Game Over!"
    # }

  play_sound: (sound) ->
    audioElement = document.createElement "audio"
    audioElement.setAttribute "src", "assets/sounds/" + sound + ".mp3"
    audioElement.setAttribute "type", "audio/mp3"
    audioElement.setAttribute "autoplay", "autoplay"
    audioElement.setAttribute "loop", "true"

    audioElement.addEventListener "load", (->
      audioElement.play()
    ), true

  get_random_number: ->
    return Math.floor((Math.random() * 9) + 1)
# Place all the behaviors and hooks related to the matching controller here.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#faq dd').hide()
  $('#faq').delegate 'dt','click', () ->
    $(this).next().toggle()


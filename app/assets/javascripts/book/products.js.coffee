# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".purchase-form").on "ajax:success", (event, data, status, xhr) ->
  $this=$(this)
  if data.status
    $this.parent('.item-box').removeClass('non-purchased').addClass 'purchased'
    $this.next(".purchase-status").text("Purchase Success").delay(1000).fadeOut
  else
    $this.next(".purchase-status").text "Purchase Failed"
  return

$(".cancel-button").on "ajax:success", (event, data, status, xhr) ->
  $this=$(this)
  if data.status
    $this.parent('.item-box').addClass('non-purchased').removeClass 'purchased'
    $this.next(".purchase-status").text("Cancel Success").delay(1000).fadeOut
  else
    $this.next(".purchase-status").text "Cancel Failed"
  return
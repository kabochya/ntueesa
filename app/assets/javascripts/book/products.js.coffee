# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".purchase-form").on "ajax:success", (event, data, status, xhr) ->
    $this = $(this)
    if data.location
      window.location = data.location
      return
    if data.status
      $this.parent(".item-box").removeClass("book-not-purchased").addClass "book-purchased"
      $this.siblings(".purchase-status").hide().text("Purchase Success").show().delay(800).fadeOut()
    else
      $this.siblings(".purchase-status").hide().text("Purchase Failed").show().delay(800).fadeOut()
    return

  $(".cancel-button").on "ajax:success", (event, data, status, xhr) ->
    $this = $(this)
    if data.location
      window.location = data.location
      return
    if data.status
      $this.parent(".item-box").addClass("book-not-purchased").removeClass "book-purchased"
      $this.siblings(".purchase-status").hide().text("Cancel Success").show().delay(800).fadeOut()
    else
      $this.siblings(".purchase-status").hide().text("Cancel Failed").show().delay(800).fadeOut()
    return

  return
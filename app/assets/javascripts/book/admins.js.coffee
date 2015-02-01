# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$('.get-dept-change-form').on "ajax:success", (event, data, status, xhr) ->
		$('.put-dept-change-form').html(data)
	return
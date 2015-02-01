# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("a").on "ajax:error", (event, jqXHR, ajaxSettings, thrownError) ->
    if jqXHR.status == 401 # thrownError is 'Unauthorized'
      window.location.replace('/department/login')
window.ajaxResponseStatusFilter = (data) ->
	if data.location
    window.location = data.location
    return true
  if data.status==-1
  	console.log('該功能無法使用')
  	return true
  return false
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.users-table').on "click", ".remark-edit", () ->
    $(this).parent().children('a,span').toggleClass('hide')
    return
  $('.users-table').on "click", ".remark-update", () ->
    content=$(this).siblings('.remark-text').text()
    input=$(this).siblings('.remark-input').children('input').val()
    if input==content or (content=='無' and input =='')
      $(this).siblings('.remark-cancel').children().trigger('click')
    else
      $(this).siblings('.submit_button').children().trigger('click')
    return
  $('.users-table').on "click", ".remark-cancel", () ->
    $(this).parent().children('a,span').toggleClass('hide')
    content=$(this).siblings('.remark-text').text()
    $(this).siblings('.remark-input').children('input').val(content)
    return
  $('.users-table').on "ajax:success",'.remark-form', (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      content=$(this).children('.remark-input').children('input').val()
      if content.length==0 then content='無'
      $(this).children('.remark-text').text(content)
      $(this).children('.remark-text,.remark-input,a').toggleClass('hide')
      $(this).children('.remark-success').fadeIn(400).delay(800).fadeOut(400);
    return

  $('.users-table').on "ajax:success",'.dept-confirm-button', (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      $(this).attr('disabled','disabled')
      $(this).parent().siblings('.dept-payment-status').html('<span class="label confirmed-payment-label">完成訂單</span>')
    return
  $('#user-detail-modal').on "ajax:success",".dept-confirm-button" , (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      $(this).attr('disabled','disabled')
      $(this).parent().siblings('.dept-payment-status').html('<span class="label confirmed-payment-label">完成訂單</span>')
      uid=parseInt($(this).parents('table').siblings('.user-info').find('.user-info-id').text())
      $target=$('.users-table').find('tr[uid="'+uid+'"]')
      $target.children('.user-payment-checked-out').text(parseInt($target.children('.user-payment-checked-out').text())-1)
      $target.children('.user-payment-confirmed').text(parseInt($target.children('.user-payment-confirmed').text())+1)
    return

  $('.users-table').on "ajax:success",'.dept-user-member-button', (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      $(this).toggleClass('success').toggleClass('alert')
      if $(this).parent().siblings('.user-is-member').text()=="會員"
        $(this).parent().siblings('.user-is-member').text("非會員")
        $(this).text('新增會員')
      else
        $(this).parent().siblings('.user-is-member').text("會員")
        $(this).text('取消會員')
    return
  $('#user-book-list-modal').on "ajax:success", ".dept-user-purchase-status-button", (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      $(this).toggleClass('success').toggleClass('alert')
      if $(this).parent().siblings('.user-purchase-status').text()=="已領取"
        $(this).parent().siblings('.user-purchase-status').text("未領取")
        $(this).text('領取')
      else
        $(this).parent().siblings('.user-purchase-status').text("已領取")
        $(this).text('取消領取')
    return
  $('#user-book-list-modal').on "ajax:success", ".dept-user-purchase-status-all-button  ", (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      $(this).remove()
      $('.user-purchase-status').text("已領取")
      $('.dept-user-purchase-status-button').text('取消領取')
    return
  return

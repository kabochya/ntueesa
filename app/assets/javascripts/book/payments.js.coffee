# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".item-button").on "click", () ->
    $('.bottom-checkout-bar').animate({bottom:0 },1000)
    return
  $(".purchase-cancel-button").on "ajax:success", (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      totalDOM=$(this).parents('tbody').find('.total')
      total = parseInt(totalDOM.text())-parseInt($(this).parent("td").next("td").text())
      totalDOM.text(total)
      if $(this).parents("tbody").children('tr').size()==1
        $(this).parents('dd.payment-accordion-navigation').slideUp(()->
          $(this).next().remove() # remove <br>
          $(this).remove()
          removeAccordianNavCallback()
          return
        )
      $(this).parents("tr").remove()
    return

  $(".payment-accordion").on "ajax:success", ".payment-cancel-button", (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      $(this).parents('dd.payment-accordion-navigation').slideUp(()->
          $(this).next().remove() # remove <br>
          $(this).remove()
          removeAccordianNavCallback()
          return
        )
    return

  $(".checkout-button").on "ajax:success", (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      removeAndReplace(data,$(this))
    return

  $(".payment-accordion").on "ajax:success",".confirm-form", (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      removeAndReplace(data,$(this))
    else
      $(this).next('.confirm-status').hide().text('確認碼登錄失敗，請重試或聯絡網管人員。').show().delay(1200).fadeOut()
    return
  $(".modify-confirm-form").on "ajax:success", (event, data, status, xhr) ->
    return if ajaxResponseStatusFilter(data)
    if data.status
      $(this).next('.confirm-status').hide().text('確認碼登錄成功，請等候處理。').show().delay(1200).fadeOut()
    else
      $(this).next('.confirm-status').hide().text('確認碼登錄失敗，請重試或聯絡網管人員。').show().delay(1200).fadeOut()
    return
  enableTopAccordion = ()->
    $('dd.payment-accordion-navigation:first').addClass('active')
    $('.payment-content:first').addClass('active')
    return
  showNoPayment = ()->
    $('.no-payments').removeClass('hide')
    return
  removeAccordianNavCallback = ()->
    if $('dd.payment-accordion-navigation').size()==0
      showNoPayment()
    else
      enableTopAccordion()
    return
  removeAndReplace = (data,$obj)->
    $parent=$obj.parents('dd.payment-accordion-navigation')
    $parent.next().remove()
    $parent.replaceWith(data.html)
    enableTopAccordion()
    return

  enableTopAccordion()  
  return

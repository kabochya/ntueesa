# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".purchase-cancel-button").on "ajax:success", (event, data, status, xhr) ->
    if data.status
      totalDOM=$(this).parents('tbody').find('.total')
      total = parseInt(totalDOM.text())-parseInt($(this).parent("td").next("td").text())
      totalDOM.text(total)
      if $(this).parents("tbody").children('tr').size()==1
        $(this).parents('dd.payment-accordion-navigation').slideUp(()->
          $(this).remove()
          removeAccordianNavCallback()
          return
        )
      $(this).parents("tr").remove()
    return

  $(".payment-accordion").on "ajax:success", ".payment-cancel-button", (event, data, status, xhr) ->
    if data.status
      $(this).parents('dd.payment-accordion-navigation').slideUp(()->
          $(this).remove()
          removeAccordianNavCallback()
          return
        )
    return

  $(".checkout-button").on "ajax:success", (event, data, status, xhr) ->
    if data.status
      $parent=$(this).parents('dd.payment-accordion-navigation')
      $parent.replaceWith(data.html)
      enableTopAccordion()
    return

  $(".confirm-form").on "ajax:success", (event, data, status, xhr) ->
    if data.status
      $parent=$(this).parents('dd.payment-accordion-navigation')
      $parent.replaceWith(data.html)
      enableTopAccordion()
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
  return

import I18n from '../packs/locales/en';
const template = require('./templates/orders/index.hbs');
import './templates/helpers/handlebars';

$(() => {
  $('[data-section="replace-orders"] .page-item').addClass('orders-link');
  changePagyLinks();

  $(".new_order").submit((event) => {
    event.preventDefault();

    $(".dish-item-wrapper").find("input:hidden:first").remove();
    const anySelectedMeal = $("input:checked").length == 0;

    $("#blank-order").val(anySelectedMeal);

    $.ajax({
      url: '/orders',
      type: 'post',
      data: $(event.target).serialize(),
      dataType: 'json',
      success: () => {
        toastr.success(I18n.t('orders.created'));
        $('input[type="submit"]').removeAttr('disabled');
      },
      error: (data) => {
        toastr.error(data.responseText);
        $('input[type="submit"]').removeAttr('disabled');
      }
    });
  });

  $('.nav-item.nav-link').click((event) => {
    event.preventDefault();

    $.ajax({
      url: $(event.target).attr('href'),
      type: 'get',
      dataType: 'json',
      success: (data) => {
        $('[data-section="replace-orders"]').replaceWith(template(data));
      }
    });
  });

  $(document).on('click', '.orders-link', ((event) => {
    event.preventDefault();

    $.ajax({
      url: $(event.target).attr('href'),
      type: 'get',
      dataType: 'json',
      success: (data) => {
        $('[data-section="replace-orders"]').replaceWith(template(data));
      }
    });
  }))
});

let changePagyLinks = () => {
  $('.page-link.orders-link').each((index, element) => {
    let pagyLink = $(element).attr('href').split('?')[1]
    $(element).attr('href') != '#' && $(element).attr('href', $('.nav-item.nav-link.active').attr('href') + "&" + pagyLink)
  });
};

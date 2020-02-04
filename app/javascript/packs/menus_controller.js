import "../packs/shared";
import I18n from '../packs/locales/en';

$(() => {
  $('.col-form-label').hide();
  
  $('.nav-link').on('click', () => {
    $('.nav-link').removeClass('active');
    $(event.target).addClass('active');
  });

  $('.orders').on('change', () => {
    showOrder();
  })

  $('.new_menu').submit((e) => {
    e.preventDefault();

    $.ajax({
      url: '/menus',
      type: 'post',
      data: $(e.target).serialize(),
      dataType: 'json',
      success: () => {
        toastr.success(I18n.t('menus.created'));
        $('.btn-outline-primary').removeAttr('disabled');
      },
      error: (data) => {
        toastr.error(data.responseText);
        $('.btn-outline-primary').removeAttr('disabled');
      }
    });
  });
  
  $.checkedOnlyOneBox();
  $.setActiveDay();
});

let showOrder = () => {
  let item = $(event.target);
  let selector = item.attr('data-select');
  let orderPosition = $(`.card-text.${selector}`);

  if (item.is(':checked')) {
    let itemPrice = item.siblings('.item-price').data('item-price');
    let itemName  = item.siblings('.item-name').data('item-name');
    orderPosition.children().text(`${itemName} ${itemPrice} UAH`);
    orderPosition.children().data('price', itemPrice);
    $('.card').addClass('d-block');
  } else {
    orderPosition.children().text(I18n.t('orders.noSelected'));
    orderPosition.children().data('price', 0)
  }
  calculateTotalCost();    
};

let calculateTotalCost = () => {
  let totalPrice = 0;

  $('.selected-item').each((index, value) => {
    totalPrice += parseInt($(value).data('price'));
  });
  
  $('.order-total-cost').text(I18n.t('orders.totalPrice', {totalPrice: totalPrice.toFixed(2)}));
};

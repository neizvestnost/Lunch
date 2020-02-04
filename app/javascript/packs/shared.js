$.checkedOnlyOneBox = () => {
  $('.orders').on('click', () => {
    let $box = $(event.target);
    if ($box.is(':checked')) {
      let group = "input:checkbox[name='" + $box.attr("name") + "']";
      $(group).prop("checked", false);
      $box.prop("checked", true);
    } else {
      $box.prop("checked", false);
    }
  });
};

$.setActiveDay = () => {
  const saturday = 6
  const sunday = 0
  let day = new Date().getDay();
  
  if (saturday == day || sunday == day) {
    $('.menus[data-day]').addClass('disabled').css("background-color", "#272e38"); 
    $('[data-day="1"]').addClass('active');
  } else {
    $('.menus[data-day]').addClass('disabled').css("background-color", "#272e38");
    $('[data-day="' + day + '"]').addClass('active');
  }
};

import "../stylesheets/application";
require("bootstrap/dist/js/bootstrap");

$(() => {
  $('.edit_user').submit(() => {
    $('select, input').each((index, element) => {
      element.disabled = !$(element).val();
    });
  });
});

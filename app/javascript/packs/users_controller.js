import './templates/helpers/handlebars';
const template = require('./templates/users/index.hbs');

$(() => {
  $('[data-section="replace-users"] .page-item').addClass('users-link');

  $(document).on('click', '.users-link', ((event) => {
    event.preventDefault();

    $.ajax({
      url: $(event.target).attr('href'),
      type: 'get',
      dataType: 'json',
      success: (data) => {
        $('[data-section="replace-users"]').replaceWith(template(data));
      } 
    })
  }));
});

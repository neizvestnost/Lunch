let Handlebars = require('handlebars/runtime');

Handlebars.registerHelper('isInteger', function(element) {
  return Number.isInteger(element);
});

Handlebars.registerHelper('isString', function(element) {
  return $.type(element) === "string" && parseInt(element)
});

Handlebars.registerHelper('createUrl', function(url, page) {
  return url.replace(/__pagy_page__/, page)
});

Handlebars.registerHelper('eq', function(element1, element2) {
   return element1 === element2
});

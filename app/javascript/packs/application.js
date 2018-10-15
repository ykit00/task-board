console.log('Hello World from Webpacker')

// import "jquery"
global.$ = require('jquery');

// JS
// import 'popper.js/dist/popper'
import 'bootstrap/dist/js/bootstrap'
import '@fortawesome/fontawesome-free/js/all'
import 'moment/moment'
// import 'tempusdominus-bootstrap-4/src/js/tempusdominus-bootstrap-4'
// import 'bootstrap4-datetimepicker/src/js/bootstrap-datetimepicker'
import 'moment/locale/ja'

// CSS
import 'bootstrap/dist/css/bootstrap.css'
import '@fortawesome/fontawesome-free/css/all.css'
import 'tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.css'
// import 'bootstrap4-datetimepicker/build/css/bootstrap-datetimepicker.css'

import Rails from 'rails-ujs'


if (!window._rails_loaded) {
  Rails.start();
}
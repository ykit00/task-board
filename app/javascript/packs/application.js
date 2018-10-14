import "jquery"
global.$ = require('jquery')

// JS
import 'popper.js/dist/popper';
import 'bootstrap/dist/js/bootstrap';
import '@fortawesome/fontawesome-free/js/all.js'

// CSS
import 'bootstrap/dist/css/bootstrap.css'
import '@fortawesome/fontawesome-free/css/all.css'


import Rails from 'rails-ujs'

if (!window._rails_loaded) {
  Rails.start();
}
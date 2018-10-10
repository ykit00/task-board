import "jquery"
global.$ = require('jquery')

// JS
import 'popper.js/dist/popper';
import 'bootstrap/dist/js/bootstrap';

// CSS
import 'bootstrap/dist/css/bootstrap.css'

import Rails from 'rails-ujs'

if (!window._rails_loaded) {
  Rails.start();
}
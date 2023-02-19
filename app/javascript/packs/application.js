// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "stylesheets/application";

// import { Application } from 'stimulus';
// import FlatpickrController from 'stimulus-flatpickr';
// import { definitionsFromContext } from 'stimulus/webpack-helpers';


Rails.start()
Turbolinks.start()
ActiveStorage.start()


// const application = Application.start();
// const context = require.context('./controllers', true, /\.js$/);
// application.load(definitionsFromContext(context));
// application.register('flatpickr', FlatpickrController);

import "controllers"


// ./packs/application.js
import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('../controllers', true, /\.js$/)
application.load(definitionsFromContext(context))

// import Flatpickr
import Flatpickr from 'stimulus-flatpickr'

// Import style for flatpickr
require("flatpickr/dist/flatpickr.css")

// Manually register Flatpickr as a stimulus controller
application.register('flatpickr', Flatpickr)
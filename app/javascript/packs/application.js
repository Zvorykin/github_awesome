// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Vue from 'vue'

import { LayoutPlugin, FormPlugin, ButtonPlugin, FormInputPlugin, CardPlugin, ToastPlugin } from 'bootstrap-vue'
Vue.use(LayoutPlugin)
Vue.use(FormPlugin)
Vue.use(ButtonPlugin)
Vue.use(FormInputPlugin)
Vue.use(CardPlugin)
Vue.use(ToastPlugin)
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import axios from 'axios'
import VueAxios from 'vue-axios'
axios.defaults.baseURL = 'http://localhost:3000/api'
Vue.use(VueAxios, axios)

import App from './app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()

  document.body.appendChild(app.$el)
})

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

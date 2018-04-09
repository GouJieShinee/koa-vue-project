// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import {get, post, all} from './http/http'

Vue.prototype.$get = get;
Vue.prototype.$post = post;
Vue.prototype.$all = all;

Vue.config.productionTip = false;

import './http/http'

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: {
    App
  },
  template: '<App/>'
});

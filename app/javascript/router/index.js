import Vue from "vue";
import Router from "vue-router";

import Top from "../pages/Top";

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Top,
    },
  ],
})

export default router

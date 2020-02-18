import Vue from "vue";
import Router from "vue-router";

import Top from "../pages/Top";
import TaskList from "../pages/TaskList";

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Top,
    },
    {
      path: '/tasks',
      component: TaskList,
    },
  ],
})

export default router

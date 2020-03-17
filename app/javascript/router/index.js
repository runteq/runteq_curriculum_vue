import Vue from "vue";
import Router from "vue-router";
import store from '../store'

import TopIndex from "../pages/top/index";
import TaskIndex from "../pages/task/index";
import RegisterIndex from "../pages/register/index";
import LoginIndex from "../pages/login/index";

Vue.use(Router)

const router = new Router({
  mode: "history",
  routes: [
    {
      path: "/",
      component: TopIndex,
      name: "TopIndex",

    },
    {
      path: "/tasks",
      component: TaskIndex,
      name: "TaskIndex",
      meta: { requiredAuth: true },
    },
    {
      path: "/register",
      component: RegisterIndex,
      name: "RegisterIndex",
    },
    {
      path: "/login",
      component: LoginIndex,
      name: "LoginIndex",
    },
  ],
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiredAuth) && !store.getters['users/isAuthenticated']) {
    next({ name: 'LoginIndex' });
  } else {
    next();
  }
});

export default router

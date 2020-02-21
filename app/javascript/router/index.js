import Vue from "vue";
import Router from "vue-router";

import TopIndex from "../pages/top/index";
import BoardIndex from "../pages/board/index";

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
      path: "/boards",
      component: BoardIndex,
      name: "BoardIndex",
    },
  ],
})

export default router

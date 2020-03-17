<template>
  <header>
    <nav class="navbar navbar-expand navbar-dark bg-dark justify-content-between">
      <span class="navbar-brand mb-0 h1">タスク管理アプリ</span>
      <ul class="navbar-nav">
        <li class="nav-item active">
          <router-link
            :to="{ name: 'RegisterIndex' }"
            class="nav-link"
          >
            ユーザー登録
          </router-link>
        </li>
        <li class="nav-item active">
          <router-link
            :to="{ name: 'LoginIndex' }"
            class="nav-link"
          >
            ログイン
          </router-link>
        </li>
      </ul>
    </nav>
  </header>
</template>

<script>
export default {
  name: "TheHeader"
}
</script>

<style scoped>

</style>

<template>
  <div class="d-flex flex-column min-vh-100">
    <header class="mb-auto">
      <nav class="navbar navbar-dark bg-dark">
        <span class="navbar-brand mb-0 h1">{{ title }}</span>
      </nav>
    </header>
    <div class="text-center">
      <h3>タスクリスト</h3>
        <router-link to="/">
          <button type="button" class="btn btn-dark mt-5">戻る</button>
        </router-link>
    </div>
    <footer class="mt-auto text-center">
      <small>Copyright &copy; 2020. RUNTEQ</small>
    </footer>
  </div>
</template>

<script>
export default {
  name: "TaskIndex",
  data() {
    return {
      title: "タスク管理アプリ"
    }
  }
}
</script>

<style scoped>
</style>

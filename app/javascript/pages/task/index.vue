<template>
  <div class="d-flex flex-column min-vh-100">
    <header class="mb-auto">
      <nav class="navbar navbar-dark bg-dark">
        <span class="navbar-brand mb-0 h1">{{ title }}</span>
      </nav>
    </header>
    <div class="d-flex">
      <div class="col-4 bg-light rounded shadow m-3 p-3">
        <div class="h4">TODO</div>
        <div v-for="task in tasks" :key="task.id" class="bg-white border shadow-sm rounded my-2 p-4">
          <span>{{ task.title }}</span>
        </div>
      </div>
    </div>
    <div class="text-center">
      <router-link :to="{ name: 'TopIndex' }" class="btn btn-dark mt-5">戻る</router-link>
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
      title: "タスク管理アプリ",
      tasks: [
        {
          id: 1,
          title: "スーパに買い物に行く"
        },
        {
          id: 2,
          title: "子供の迎えに行く"
        },
        {
          id: 3,
          title: "新聞を解約する"
        },
        {
          id: 4,
          title: "ゴミ出しをする"
        },
      ]
    }
  }
}
</script>

<style scoped>
</style>

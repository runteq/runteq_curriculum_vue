<template>
  <div>
    <div class="d-flex">
      <div class="col-4 bg-light rounded shadow m-3 p-3">
        <div class="h4">TODO</div>
        <TaskItem v-for="task in tasks" :key="task.id" :task="task" />
      </div>
    </div>
    <div class="text-center">
      <router-link :to="{ name: 'TopIndex' }" class="btn btn-dark mt-5">戻る</router-link>
    </div>
  </div>
</template>

<script>
import TaskItem from "./components/TaskItem"

export default {
  name: "TaskIndex",
  components: {
    TaskItem
  },
  data() {
    return {
      tasks: []
    }
  },
  created() {
    this.fetchTasks();
  },
  methods: {
    fetchTasks() {
      this.$axios.get("tasks")
        .then(res => this.tasks = res.data)
        .catch(err => console.log(err.status));
    }
  }
}
</script>

<style scoped>
</style>

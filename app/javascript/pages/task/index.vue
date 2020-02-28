<template>
  <div>
    <div class="d-flex">
      <div class="col-4 bg-light rounded shadow m-3 p-3">
        <div class="h4">TODO</div>
        <TaskItem v-for="task in tasks" :key="task.id" :task="task" @click.native="handleShowModal(task)" />
      </div>
    </div>
    <div class="text-center">
      <router-link :to="{ name: 'TopIndex' }" class="btn btn-dark mt-5">戻る</router-link>
    </div>
    <transition name="fade">
      <TaskModal v-if="isVisibleTaskModal" :task="taskDetail" @close-modal="handleCloseModal" />
    </transition>
  </div>
</template>

<script>
import TaskItem from "./components/TaskItem"
import TaskModal from "./components/TaskModal"

export default {
  name: "TaskIndex",
  components: {
    TaskItem,
    TaskModal
  },
  data() {
    return {
      tasks: [],
      taskDetail: {},
      isVisibleTaskModal: false
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
    },
    handleShowModal(task) {
      this.isVisibleTaskModal = true;
      this.taskDetail = task;
    },
    handleCloseModal() {
      this.isVisibleTaskModal = false;
      this.taskDetail = {};
    }
  }
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity .5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>

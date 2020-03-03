<template>
  <div>
    <div class="d-flex">
      <div class="col-4 bg-light rounded shadow m-3 p-3">
        <div class="h4">TODO</div>
        <div
          v-for="task in tasks"
          :key="task.id"
          :id="'task-' + task.id"
          class="bg-white border shadow-sm rounded my-2 p-4"
          @click="handleShowModal(task)"
        >
          <span>{{ task.title }}</span>
        </div>
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
import TaskModal from "./components/TaskModal"

export default {
  name: "TaskIndex",
  components: {
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

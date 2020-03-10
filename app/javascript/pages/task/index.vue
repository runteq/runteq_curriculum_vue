<template>
  <div>
    <div class="row">
      <task-list :tasks="todoTasks"
        @handleShowTaskDetailModal="handleShowTaskDetailModal"
        @handleShowTaskCreateModal="handleShowTaskCreateModal"
        @handleShowTaskEditModal="handleShowTaskEditModal"
        @handleDeleteTask="handleDeleteTask"
        task-status="todo"
      >
        <template v-slot:header>
          <div class="h4">TODO</div>
        </template>
      </task-list>
      <task-list :tasks="doneTasks"
        @handleShowTaskDetailModal="handleShowTaskDetailModal"
        @handleShowTaskCreateModal="handleShowTaskCreateModal"
        @handleShowTaskEditModal="handleShowTaskEditModal"
        @handleDeleteTask="handleDeleteTask"
        task-status="done"
      >
        <template v-slot:header>
          <div class="h4">DONE</div>
        </template>
      </task-list>
    </div>
    <div class="text-center">
      <router-link :to="{ name: 'TopIndex' }" class="btn btn-dark mt-5">戻る</router-link>
    </div>
    <transition name="fade">
      <TaskDetailModal v-if="isVisibleTaskDetailModal" :task="taskDetail" @close-modal="handleCloseTaskDetailModal" />
    </transition>
    <transition name="fade">
      <TaskCreateModal
        v-if="isVisibleTaskCreateModal"
        @close-modal="handleCloseTaskCreateModal"
        @create-task="handleCreateTask"
        :task="newTask"
      />
    </transition>
    <transition name="fade">
      <TaskEditModal
        v-if="isVisibleTaskEditModal"
        :task="taskEdit"
        @close-modal="handleCloseTaskEditModal"
        @update-task="handleUpdateTask"
      />
    </transition>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import TaskDetailModal from "./components/TaskDetailModal"
import TaskCreateModal from "./components/TaskCreateModal"
import TaskEditModal from "./components/TaskEditModal"
import TaskList from "./components/TaskList"

export default {
  name: "TaskIndex",
  components: {
    TaskList,
    TaskDetailModal,
    TaskCreateModal,
    TaskEditModal
  },
  data() {
    return {
      taskDetail: {},
      isVisibleTaskDetailModal: false,
      isVisibleTaskCreateModal: false,
      isVisibleTaskEditModal: false,
      taskEdit: {},
      newTask: {}
    }
  },
  computed: {
    ...mapGetters(["tasks"]),
    todoTasks() {
      return this.tasks.filter(task => {
        return task.status == "todo"
      })
    },
    doneTasks() {
      return this.tasks.filter(task => {
        return task.status == "done"
      })
    }
  },
  created() {
    this.fetchTasks();
  },
  methods: {
    ...mapActions([
      "fetchTasks",
      "createTask",
      "deleteTask",
      "updateTask"
    ]),
    handleShowTaskDetailModal(task) {
      this.isVisibleTaskDetailModal = true;
      this.taskDetail = task;
    },
    handleCloseTaskDetailModal() {
      this.isVisibleTaskDetailModal = false;
      this.taskDetail = {};
    },
    handleShowTaskCreateModal(taskStatus) {
      this.newTask = { status: taskStatus }
      this.isVisibleTaskCreateModal = true;
    },
    handleCloseTaskCreateModal() {
      this.isVisibleTaskCreateModal = false;
    },
    handleShowTaskEditModal(task) {
      this.taskEdit = Object.assign({}, task)
      this.isVisibleTaskEditModal = true;
    },
    handleCloseTaskEditModal() {
      this.isVisibleTaskEditModal = false;
      this.taskEdit = {};
    },
    async handleCreateTask(task) {
      try {
        await this.createTask(task)
        this.handleCloseTaskCreateModal()
      } catch (error) {
        console.log(error)
      }
    },
    async handleDeleteTask(task) {
      try {
        await this.deleteTask(task)
      } catch (error) {
        console.log(error)
      }
    },
    async handleUpdateTask(task) {
      try {
        await this.updateTask(task)
        this.handleCloseTaskEditModal()
      } catch (error) {
        console.log(error)
      }
    },
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

<template>
  <div class="container-fluid">
    <div class="form-row p-3">
      <div class="form-group col-lg-6">
        <label for="search">絞り込み</label>
        <input type="text" v-model="searchTask" class="form-control" id="search" placeholder="タスク名を入力してください">
      </div>
    </div>
    <div class="row">
      <TaskList
        :tasks="todoTasks"
        task-list-id="todo-list"
        @handleShowTaskDetailModal="handleShowTaskDetailModal"
      >
        <template v-slot:header>
          <div class="h4">
            TODO
          </div>
        </template>
      </TaskList>
      <TaskList
        :tasks="doingTasks"
        task-list-id="doing-list"
        @handleShowTaskDetailModal="handleShowTaskDetailModal"
      >
        <template v-slot:header>
          <div class="h4">
            DOING
          </div>
        </template>
      </TaskList>
      <TaskList
        :tasks="doneTasks"
        task-list-id="done-list"
        @handleShowTaskDetailModal="handleShowTaskDetailModal"
      >
        <template v-slot:header>
          <div class="h4">
            DONE
          </div>
        </template>
      </TaskList>
    </div>
    <div class="text-center">
      <button
        class="btn btn-secondary"
        @click="handleShowTaskCreateModal"
      >
        タスクを追加
      </button>
    </div>
    <div class="text-center">
      <router-link
        :to="{ name: 'TopIndex' }"
        class="btn btn-dark mt-5"
      >
        戻る
      </router-link>
    </div>
    <transition name="fade">
      <TaskDetailModal
        v-if="isVisibleTaskDetailModal"
        :task="taskDetail"
        :auth-user="authUser"
        @close-modal="handleCloseTaskDetailModal"
        @delete-task="handleDeleteTask"
        @show-edit-modal="handleShowTaskEditModal"
      />
    </transition>
    <transition name="fade">
      <TaskCreateModal
        v-if="isVisibleTaskCreateModal"
        @close-modal="handleCloseTaskCreateModal"
        @create-task="handleCreateTask"
      />
    </transition>
    <TaskEditModal
      v-if="isVisibleTaskEditModal"
      :task="taskEdit"
      @close-modal="handleCloseTaskEditModal"
      @update-task="handleUpdateTask"
    />
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
      searchTask: ""
    }
  },
  computed: {
    ...mapGetters("tasks", ["tasks"]),
    ...mapGetters("users", ["authUser"]),
    todoTasks() {
      return this.tasks.filter(task => {
        return task.status == "todo"
      })
    },
    doingTasks() {
      return this.tasks.filter(task => {
        return task.status == "doing"
      })
    },
    doneTasks() {
      return this.tasks.filter(task => {
        return task.status == "done"
      })
    },
    filteredTasks() {
      return this.tasks.filter(task => {
        return task.title.indexOf(this.searchTask) != -1
      })
    }
  },
  created() {
    this.fetchTasks();
  },
  methods: {
    ...mapActions("tasks", [
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
    handleShowTaskCreateModal() {
      this.isVisibleTaskCreateModal = true;
    },
    handleCloseTaskCreateModal() {
      this.isVisibleTaskCreateModal = false;
    },
    handleShowTaskEditModal(task) {
      this.taskEdit = Object.assign({}, task)
      this.handleCloseTaskDetailModal();
      this.isVisibleTaskEditModal = true;
    },
    handleCloseTaskEditModal() {
      this.isVisibleTaskEditModal = false;
      this.taskEdit = {};
    },
    async handleCreateTask(task) {
      try {
        await this.createTask(task);
        this.handleCloseTaskCreateModal();
      } catch (error) {
        console.log(error);
      }
    },
    async handleDeleteTask(task) {
      try {
        await this.deleteTask(task);
        this.handleCloseTaskDetailModal();
      } catch (error) {
        console.log(error);
      }
    },
    async handleUpdateTask(task) {
      try {
        await this.updateTask(task);
        this.handleCloseTaskEditModal();
      } catch (error) {
        console.log(error);
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

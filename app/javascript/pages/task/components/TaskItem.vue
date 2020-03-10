<template>
  <div
          :key="task.id"
          :id="'task-' + task.id"
          class="bg-white border shadow-sm rounded my-2 p-4 d-flex align-items-center"
          @click="handleShowTaskDetailModal(task)"
  >
    <div class="col-8">
      <span>{{ task.title }}</span>
    </div>
    <div class="col-4 text-right">
      <button type="button" class="btn btn-success" @click.stop="handleShowTaskEditModal(task)">編集</button>
      <button type="button" class="btn btn-danger" @click.stop="handleDeleteTask(task)">削除</button>
    </div>
  </div>
</template>

<script>
  export default {
    name: "Task",
    props: {
      task: {
        type: Object,
        required: true
      }
    },

    methods: {
      handleShowTaskDetailModal(task) {
        this.$emit('handleShowTaskDetailModal', task)
      },
      handleShowTaskCreateModal() {
        this.$emit('handleShowTaskCreateModal')
      },
      handleShowTaskEditModal(task) {
        this.$emit('handleShowTaskEditModal', task)
      },
      handleDeleteTask(task) {
        this.$emit('handleDeleteTask', task)
      }
    }
  }
</script>

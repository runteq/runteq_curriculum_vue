<template>
  <div
    :id="'task-' + task.id"
    class="bg-white border shadow-sm rounded my-2 p-4 d-flex align-items-center"
    @click="handleShowTaskDetailModal(task)"
  >
    <span>{{ task.title }}</span>
  </div>
</template>

<script>
export default {
  name: "TaskItem",
  props: {
    task: {
      type: Object,
      required: true
    }
  },
  methods: {
    handleShowTaskDetailModal(task) {
      this.$emit('handleShowTaskDetailModal', task)
    }
  }
}
</script>

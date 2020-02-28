<template>
  <div class="bg-white border shadow-sm rounded my-2 p-4">
    <span>{{ task.title }}</span>
  </div>
</template>

<script>
export default {
  name: "TaskItem",
  props: {
    task: {
      title: {
        type: String,
        required: true
      }
    }
  }
}
</script>

<style scoped>
</style>

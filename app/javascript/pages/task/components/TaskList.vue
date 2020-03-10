<template>
  <div class="col-12 col-lg-6">
    <div class="bg-light rounded shadow m-3 p-3">
      <slot name="header">タスク区分</slot>
      <template v-for="task in tasks">
        <task :task="task"
          @handleShowTaskDetailModal="$listeners['handleShowTaskDetailModal']"
          @handleShowTaskCreateModal="$listeners['handleShowTaskCreateModal']"
          @handleShowTaskEditModal="$listeners['handleShowTaskEditModal']"
          @handleDeleteTask="$listeners['handleDeleteTask']"
        >
        </task>
      </template>
      <button class="btn btn-secondary" @click="handleShowTaskCreateModal">タスクを追加</button>
    </div>
  </div>
</template>
<script>
  import Task from "./Task"
  export default {
    name: "TaskIndex",
    props: {
      tasks: {
        type: Array,
        required: true
      }
    },
    components: {
      Task
    },

    methods: {
      handleShowTaskCreateModal() {
        this.$emit('handleShowTaskCreateModal')
      },
    }
  }
</script>

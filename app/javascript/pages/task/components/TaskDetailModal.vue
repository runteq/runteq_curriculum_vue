<template>
  <div :id="'task-detail-modal-' + task.id">
    <div
      class="modal"
      @click.self="handleCloseModal"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              {{ task.title }}
            </h5>
            <button
              type="button"
              class="close"
              @click="handleCloseModal"
            >
              <span>&times;</span>
            </button>
          </div>
          <div
            v-if="task.description"
            class="modal-body"
          >
            <p>{{ task.description }}</p>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-success"
              @click="handleShowTaskEditModal"
            >
              編集
            </button>
            <button
              type="button"
              class="btn btn-danger"
              @click="handleDeleteTask"
            >
              削除
            </button>
            <button
              type="button"
              class="btn btn-secondary"
              @click="handleCloseModal"
            >
              閉じる
            </button>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show" />
  </div>
</template>

<script>
export default {
  name: "TaskDetailModal",
  props: {
    task: {
      id: {
        type: Number,
        required: true
      },
      title: {
        type: String,
        required: true
      },
      description: {
        type: String,
        required: true
      }
    }
  },
  methods: {
    handleCloseModal() {
      this.$emit('close-modal')
    },
    handleShowTaskEditModal() {
      this.$emit('show-edit-modal', this.task)
    },
    handleDeleteTask() {
      this.$emit('delete-task', this.task)
    },
  }
}
</script>

<style scoped>
.modal {
  display: block;
}
</style>

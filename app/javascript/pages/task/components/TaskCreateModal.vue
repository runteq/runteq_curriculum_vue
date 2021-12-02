<template>
  <div id="task-create-modal">
    <div class="modal" @click.self="handleCloseModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body">
            <div class="form-group">
              <label for="title">タイトル</label>
              <input
                type="text"
                class="form-control"
                id="title"
                v-model="task.title"
              >
            </div>
            <div class="form-group">
              <label for="description">説明文</label>
              <textarea
                class="form-control"
                id="description"
                rows="5"
                v-model="task.description"
              ></textarea>
            </div>
            <div class="d-flex justify-content-between">
              <button class="btn btn-success" @click="handleCreateTask">追加</button>
              <button class="btn btn-secondary" @click="handleCloseModal">閉じる</button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show"></div>
  </div>
</template>

<script>
export default {
  name: "TaskCreateModal",
  data() {
    return {
      task: {
        title: '',
        description: ''
      }
    }
  },
  methods: {
    handleCloseModal() {
      this.$emit('close-modal')
    },
    handleCreateTask() {
      this.$emit('create-task', this.task)
    }
  }
}
</script>

<style scoped>
.modal {
  display: block;
}
</style>

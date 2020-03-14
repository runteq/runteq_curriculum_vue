<template>
  <div id="task-create-modal">
    <div
      class="modal"
      @click.self="handleCloseModal"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body">
            <div class="form-group">
              <label for="title">タイトル</label>
              <input
                id="title"
                v-model="task.title"
                type="text"
                class="form-control"
              >
            </div>
            <div class="form-group">
              <label for="description">説明文</label>
              <textarea
                id="description"
                v-model="task.description"
                class="form-control"
                rows="5"
              />
            </div>
            <div class="form-group">
              <label for="status">ステータス</label>
              <select
                id="status"
                v-model="task.status"
                class="form-control"
              >
                <option value="todo">
                  TODO
                </option>
                <option value="doing">
                  DOING
                </option>
                <option value="done">
                  DONE
                </option>
              </select>
            </div>
            <div class="d-flex justify-content-between">
              <button
                class="btn btn-success"
                @click="handleCreateTask"
              >
                追加
              </button>
              <button
                class="btn btn-secondary"
                @click="handleCloseModal"
              >
                閉じる
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show" />
  </div>
</template>

<script>
export default {
  name: "TaskCreateModal",
  data() {
    return {
      task: {
        title: '',
        description: '',
        status: ''
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

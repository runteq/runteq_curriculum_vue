<template>
  <div :id="'task-edit-modal-' + task.id">
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
                @click="handleUpdateTask"
              >
                更新
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
  name: "TaskEditModal",
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
      },
      status: {
        type: String,
        required: true
      }
    }
  },
  methods: {
    handleCloseModal() {
      this.$emit('close-modal')
    },
    handleUpdateTask() {
      this.$emit('update-task', this.task)
    }
  }
}
</script>

<style scoped>
.modal {
  display: block;
}
</style>

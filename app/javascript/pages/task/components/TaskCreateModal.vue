<template>
  <div id="task-create-modal">
    <div
      class="modal"
      @click.self="handleCloseModal"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body">
            <ValidationObserver v-slot="{ handleSubmit }">
              <div class="form-group">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:50"
                >
                  <label for="title">タイトル</label>
                  <input
                    id="title"
                    v-model="task.title"
                    name="タイトル"
                    type="text"
                    class="form-control"
                  >
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="form-group">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="max:500"
                >
                  <label for="description">説明文</label>
                  <textarea
                    id="description"
                    v-model="task.description"
                    name="説明文"
                    class="form-control"
                    rows="5"
                  />
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="form-group">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required"
                >
                  <label for="status">ステータス</label>
                  <select
                    id="status"
                    v-model="task.status"
                    name="ステータス"
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
                  <span class="text-danger">{{ errors[0] }}</span>
                </ValidationProvider>
              </div>
              <div class="d-flex justify-content-between">
                <button
                  class="btn btn-success"
                  @click="handleSubmit(handleCreateTask)"
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
            </ValidationObserver>
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

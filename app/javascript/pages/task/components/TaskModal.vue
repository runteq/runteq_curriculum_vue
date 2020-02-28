<template>
  <div>
    <div class="modal" @click.self="handleCloseModal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ task.title }}</h5>
            <button type="button" class="close" @click="handleCloseModal">
              <span>&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <p>Modal body text goes here.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" @click="handleCloseModal">閉じる</button>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-backdrop show"></div>
  </div>
</template>

<script>
export default {
  name: "TaskModal",
  props: {
    task: {
      title: {
        type: String,
        required: true
      }
    }
  },
  methods: {
    handleCloseModal() {
      this.$emit('close-modal')
    }
  }
}
</script>

<style scoped>
.modal {
  display: block;
}
</style>

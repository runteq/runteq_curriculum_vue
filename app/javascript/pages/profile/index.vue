<template>
  <div
    id="login-form"
    class="container w-50 text-center"
  >
    <div class="h3 mb-3">
      プロフィール
    </div>
    <ValidationObserver v-slot="{ handleSubmit }">
      <div class="form-group text-left">
        <ValidationProvider
                v-slot="{ errors }"
                rules="required"
        >
          <label for="name">ユーザー名</label>
          <input
                  id="name"
                  v-model="user.name"
                  name="ユーザー名"
                  type="text"
                  class="form-control"
                  placeholder="username"
          >
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>
      </div>
      <div class="form-group text-left">
        <ValidationProvider
          v-slot="{ errors }"
          rules=""
        >
          <label for="avatar">プロフィール画像</label>
          <input
            id="avatar"
            name="プロフィール画像"
            type="file"
            class="form-control-file"
          >
          <span class="text-danger">{{ errors[0] }}</span>
        </ValidationProvider>
      </div>
      <button
        type="submit"
        class="btn btn-primary"
        @click="handleSubmit(update)"
      >
        更新
      </button>
    </ValidationObserver>
  </div>
</template>

<script>
export default {
  name: "ProfileIndex",
  data() {
    return {
      user: {
        name: "あああ",
        avatar_url: "aaaaaaaaaa",
      }
    }
  }
}
</script>

<style scoped>
</style>

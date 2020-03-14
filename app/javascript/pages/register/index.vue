<template>
  <div class="container w-50 text-center">
    <div class="h3 mb-3">ユーザー登録</div>
    <div class="form-group text-left">
      <label for="name">ユーザー名</label>
      <input
        type="text"
        class="form-control"
        id="name"
        placeholder="username"
        v-model="user.name"
      >
    </div>
    <div class="form-group text-left">
      <label for="email">メールアドレス</label>
      <input
        type="email"
        class="form-control"
        id="email"
        placeholder="test@example.com"
        v-model="user.email"
      >
    </div>
    <div class="form-group text-left">
      <label for="password">パスワード</label>
      <input
        type="password"
        class="form-control"
        id="password"
        placeholder="password"
        v-model="user.password"
      >
    </div>
    <div class="form-group text-left">
      <label for="password_confirmation">パスワード（確認）</label>
      <input
        type="password"
        class="form-control"
        id="password_confirmation"
        placeholder="password"
        v-model="user.password_confirmation"
      >
    </div>
    <button type="submit" class="btn btn-primary" @click="register">登録</button>
  </div>
</template>

<script>
export default {
  name: "RegisterIndex",
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      }
    }
  },
  methods: {
    register() {
      console.log('register')
    }
  }
}
</script>

<style scoped>
</style>

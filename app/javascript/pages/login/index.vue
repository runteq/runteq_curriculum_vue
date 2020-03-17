<template>
  <div class="container w-50 text-center">
    <div class="h3 mb-3">ログイン</div>
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
    <button type="submit" class="btn btn-primary" @click="login">ログイン</button>
  </div>
</template>

<script>
import { mapActions } from "vuex"

export default {
  name: "LoginIndex",
  data() {
    return {
      user: {
        email: "",
        password: "",
      }
    }
  },
  methods: {
    ...mapActions("users", [
      "loginUser",
      "fetchUser",
    ]),
    async login() {
      try {
        await this.loginUser(this.user);
        this.$router.push({ name: 'TaskIndex' })
      } catch (error) {
        console.log(error);
      }
    }
  }
}
</script>

<style scoped>
</style>

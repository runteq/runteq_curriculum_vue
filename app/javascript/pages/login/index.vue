<template>
  <div class="container w-50 text-center">
    <div class="h3 mb-3">
      ログイン
    </div>
    <div class="form-group text-left">
      <ValidationProvider rules="required|email" v-slot="{ errors }">
        <label for="email">メールアドレス</label>
        <input
          id="email"
          name="メールアドレス"
          v-model="user.email"
          type="email"
          class="form-control"
          placeholder="test@example.com"
        >
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>
    </div>
    <div class="form-group text-left">
      <ValidationProvider rules="required|min:3" v-slot="{ errors }">
        <label for="password">パスワード</label>
        <input
          id="password"
          name="パスワード"
          v-model="user.password"
          type="password"
          class="form-control"
          placeholder="password"
        >
        <span class="text-danger">{{ errors[0] }}</span>
      </ValidationProvider>
    </div>
    <button
      type="submit"
      class="btn btn-primary"
      @click="login"
    >
      ログイン
    </button>
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

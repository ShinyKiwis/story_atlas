<script setup>
import { useForm } from 'vee-validate';
import { object, string } from 'yup';
import { useI18n } from 'vue-i18n';
import { ref } from 'vue';
import Icon from 'components/Icon.vue';
import AppTitle from 'components/AppTitle.vue';

const { t } = useI18n();
const { values, errors, defineField, meta, handleSubmit } = useForm({
  validationSchema: object({
    username: string().required(() => t('SESSION.ERRORS.USERNAME_REQUIRED')),
    password: string()
      .required(() => t('SESSION.ERRORS.PASSWORD_REQUIRED'))
  })
})

const phase = ref('intro');
const showPassword = ref(false);

const [username, usernameAttrs] = defineField('username');
const [password, passwordAttrs] = defineField('password');

const onSubmit= handleSubmit(async data => {
  console.log('here')
})

</script>
<template>
  <div class="h-screen bg-grid bg-base flex items-center justify-center">
    <div>
      <AppTitle />
      <div class="rounded-2xl border border-white/10 bg-white/5 p-8 backdrop-blur-sm">
        <h2 class="mb-1 text-2xl font-bold text-white font-sans">{{ t('SESSION.WELCOME_BACK') }}</h2>
        <p class="mb-6 text-sm text-white/40 font-mono">{{ t('SESSION.SUBTITLE') }}</p>

        <form @submit='onSubmit'>
          <div class="space-y-4">
            <div>
              <label class="mb-1 block text-xs text-white/50 font-mono uppercase tracking-widest">{{ t('SESSION.USERNAME') }}</label>
              <input
                v-model='username'
                v-bind='usernameAttrs'
                type="text"
                class="w-full rounded-lg border border-white/10 bg-white/5 px-4 py-2.5 text-white placeholder-white/20 outline-none focus:border-sky-400/50 focus:ring-1 focus:ring-sky-400/20 transition"
                :placeholder="t('SESSION.USERNAME_PLACEHOLDER')"
              />
              <p v-if="errors.username" class="mt-1.5 text-xs text-red-400 font-mono">{{ errors.username }}</p>
            </div>
            <div>
              <label class="mb-1 block text-xs text-white/50 font-mono uppercase tracking-widest">{{ t('SESSION.PASSWORD') }}</label>
              <div class="relative">
                <input
                  v-model='password'
                  v-bind='passwordAttrs'
                  :type="showPassword ? 'text' : 'password'"
                  class="w-full rounded-lg border border-white/10 bg-white/5 px-4 py-2.5 pr-11 text-white placeholder-white/20 outline-none focus:border-sky-400/50 focus:ring-1 focus:ring-sky-400/20 transition"
                  placeholder="••••••••"
                />
                <button type="button" @click="showPassword = !showPassword" class="absolute right-3 top-1/2 -translate-y-1/2 text-white/30 hover:text-white/70 transition">
                  <Icon v-if="!showPassword" name="eye" class="w-5 h-5" />
                  <Icon v-else name="eye-off" class="w-5 h-5" />
                </button>
              </div>
              <p v-if="errors.password" class="mt-1.5 text-xs text-red-400 font-mono">{{ errors.password }}</p>
            </div>
          </div>

          <button
            :disabled="!meta.valid"
            class="mt-6 w-full rounded-lg bg-sky-500 py-2.5 font-bold text-white font-sans hover:bg-sky-400 transition cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {{ t('SESSION.LOGIN') }}
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

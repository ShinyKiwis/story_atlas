<script setup>
import FirstRunAPI from 'api/firstRun';
import { useForm } from 'vee-validate';
import { object, string } from 'yup';
import { ref, onMounted } from 'vue';
import { useI18n } from 'vue-i18n';
import { useRouter } from 'vue-router';
import Icon from 'components/Icon.vue';
import AppTitle from 'components/AppTitle.vue';

const { t } = useI18n();
const router = useRouter();
const { values, errors, defineField, meta, handleSubmit } = useForm({
  validationSchema: object({
    username: string().required(() => t('FIRST_RUN.ERRORS.USERNAME_REQUIRED')),
    password: string()
      .required(() => t('FIRST_RUN.ERRORS.PASSWORD_REQUIRED'))
      .min(8, () => t('FIRST_RUN.ERRORS.PASSWORD_MIN'))
      .matches(/[A-Z]/, () => t('FIRST_RUN.ERRORS.PASSWORD_UPPERCASE'))
      .matches(/[^a-zA-Z0-9]/, () => t('FIRST_RUN.ERRORS.PASSWORD_SPECIAL'))
  })
})

const phase = ref('intro');
const showPassword = ref(false);

const [username, usernameAttrs] = defineField('username');
const [password, passwordAttrs] = defineField('password');

const onSubmit= handleSubmit(async data => {
  try {
    await FirstRunAPI.create(data)
    router.push({name: 'dashboard'})
  } catch(error) {
    console.error(error.message);
  }
})

onMounted(() => {
  setTimeout(() => { phase.value = 'form' }, 2800)
})
</script>

<template>
  <div class="h-screen bg-grid bg-base flex items-center justify-center">
    <Transition name="scene" mode="out-in">

      <div v-if="phase === 'intro'" key="intro" class="text-center select-none">
        <h1 class="text-7xl font-extrabold font-sans tracking-widest">
          <span class="title-story text-white">Story</span><span class="title-atlas text-sky-400">Atlas</span>
        </h1>
        <p class="tagline mt-4 text-white/30 text-sm font-mono tracking-[0.3em] uppercase">
          {{ t('FIRST_RUN.TAGLINE') }}
        </p>
      </div>

      <div v-else key="form" class="w-full max-w-md px-4">
        <AppTitle />
        <div class="rounded-2xl border border-white/10 bg-white/5 p-8 backdrop-blur-sm">
          <h2 class="mb-1 text-2xl font-bold text-white font-sans">{{ t('FIRST_RUN.WELCOME') }}</h2>
          <p class="mb-6 text-sm text-white/40 font-mono">{{ t('FIRST_RUN.SUBTITLE') }}</p>

          <form @submit='onSubmit'>
            <div class="space-y-4">
              <div>
                <label class="mb-1 block text-xs text-white/50 font-mono uppercase tracking-widest">{{ t('FIRST_RUN.USERNAME') }}</label>
                <input
                  v-model='username'
                  v-bind='usernameAttrs'
                  type="text"
                  class="w-full rounded-lg border border-white/10 bg-white/5 px-4 py-2.5 text-white placeholder-white/20 outline-none focus:border-sky-400/50 focus:ring-1 focus:ring-sky-400/20 transition"
                  :placeholder="t('FIRST_RUN.USERNAME_PLACEHOLDER')"
                />
                <p v-if="errors.username" class="mt-1.5 text-xs text-red-400 font-mono">{{ errors.username }}</p>
              </div>
              <div>
                <label class="mb-1 block text-xs text-white/50 font-mono uppercase tracking-widest">{{ t('FIRST_RUN.PASSWORD') }}</label>
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
              {{ t('FIRST_RUN.GET_STARTED') }}
            </button>
          </form>
        </div>
      </div>

    </Transition>
  </div>
</template>

<style scoped>
.title-story {
  display: inline-block;
  animation: blurReveal 0.9s cubic-bezier(0.16, 1, 0.3, 1) forwards;
  opacity: 0;
}

.title-atlas {
  display: inline-block;
  animation: blurReveal 0.9s cubic-bezier(0.16, 1, 0.3, 1) 0.15s forwards,
             glowPulse 1s ease-in-out 1s forwards;
  opacity: 0;
}

.tagline {
  animation: fadeUp 0.7s ease 0.7s forwards;
  opacity: 0;
}

@keyframes blurReveal {
  from { opacity: 0; transform: translateY(12px) scale(0.95); filter: blur(10px); }
  to   { opacity: 1; transform: translateY(0) scale(1);       filter: blur(0); }
}

@keyframes glowPulse {
  0%   { text-shadow: none; }
  50%  { text-shadow: 0 0 40px rgba(56, 189, 248, 0.5), 0 0 80px rgba(56, 189, 248, 0.25); }
  100% { text-shadow: 0 0 20px rgba(56, 189, 248, 0.2); }
}

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(6px); }
  to   { opacity: 1; transform: translateY(0); }
}

.scene-enter-active { transition: opacity 0.6s ease, transform 0.6s ease; }
.scene-leave-active { transition: opacity 0.4s ease, transform 0.4s ease; }
.scene-enter-from   { opacity: 0; transform: translateY(12px); }
.scene-leave-to     { opacity: 0; transform: scale(1.04); }
</style>


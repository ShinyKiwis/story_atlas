import './application.css';
import { createApp } from 'vue';
import { createI18n } from 'vue-i18n';
import { createPinia } from 'pinia';
import i18nMessages from '../i18n';
import App from '../App.vue';
import router from '../routes';

// https://vue-i18n.intlify.dev/guide/advanced/composition
const i18n = createI18n({
  legacy: false,
  locale: 'en',
  messages: i18nMessages
})

const pinia = createPinia();

const app = createApp(App);
app.use(i18n);
app.use(pinia);
app.use(router);
app.mount('#app');

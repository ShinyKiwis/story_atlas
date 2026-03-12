import './application.css';
import { createApp } from 'vue';
import { createI18n } from 'vue-i18n';
import i18nMessages from '../i18n';
import App from '../App.vue';
import router from '../routes';

const i18n = createI18n({
  locale: 'en',
  messages: i18nMessages
})

const app = createApp(App);
app.use(i18n);
app.use(router);
app.mount('#app');

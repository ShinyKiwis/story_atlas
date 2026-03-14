import { createRouter, createWebHistory } from 'vue-router';
import firstRun from './firstRun.routes';
import dashboard from './dashboard/dashboard.routes';
import session from './session/session.routes';

const routes = [
  ...firstRun.routes,
  ...session.routes,
  ...dashboard.routes
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router;

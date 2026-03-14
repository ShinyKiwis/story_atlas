import { createRouter, createWebHistory } from 'vue-router';
import firstRun from './firstRun.routes';
import dashboard from './dashboard/dashboard.routes';

const routes = [
  ...firstRun.routes,
  ...dashboard.routes
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router;

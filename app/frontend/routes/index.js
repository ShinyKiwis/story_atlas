import { createRouter, createWebHistory } from 'vue-router';
import firstRun from './firstRun.routes';

const routes = [
  ...firstRun.routes
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router;

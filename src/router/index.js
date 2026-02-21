import { createRouter, createWebHistory } from 'vue-router'

// 页面组件
const Home = () => import('@/views/Home.vue')
const Interview = () => import('@/views/Interview.vue')
const MapGenerator = () => import('@/views/MapGenerator.vue')
const Resources = () => import('@/views/Resources.vue')

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
    meta: { title: '人生重置向导 - 重新设计你想要的生活' }
  },
  {
    path: '/interview',
    name: 'Interview',
    component: Interview,
    meta: { title: '人生重置访谈 - 五个简单步骤' }
  },
  {
    path: '/map',
    name: 'MapGenerator',
    component: MapGenerator,
    meta: { title: '人生重置地图 - 个性化行动计划' }
  },
  {
    path: '/resources',
    name: 'Resources',
    component: Resources,
    meta: { title: '资源推荐 - 帮助你更好地行动' }
  },
  // 404页面 - 重定向到首页
  {
    path: '/:pathMatch(.*)*',
    redirect: '/'
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0 }
    }
  }
})

// 全局前置守卫
router.beforeEach((to, from, next) => {
  // 设置页面标题
  if (to.meta.title) {
    document.title = to.meta.title
  }
  next()
})

export default router
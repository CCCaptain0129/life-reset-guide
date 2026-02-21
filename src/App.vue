<template>
  <div id="app">
    <!-- 主要内容区域 -->
    <main class="app-main">
      <router-view />
    </main>
    
    <!-- 简洁的页脚 - 只在非首页显示 -->
    <footer class="app-footer" v-if="showFooter">
      <div class="footer-content">
        <p class="footer-text">&copy; 2026 人生重置向导</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

// 根据当前路由决定是否显示页脚
const showFooter = computed(() => {
  // 首页不显示页脚，其他页面显示简洁页脚
  return route.path !== '/'
})
</script>

<style scoped>
#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  /* 背景由各页面组件自己控制 */
}

.app-main {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.app-footer {
  padding: 1.5rem 1rem;
  text-align: center;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
}

.footer-text {
  color: rgba(255, 255, 255, 0.8);
  font-size: 0.9rem;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .app-footer {
    padding: 1rem;
  }
}

/* 深色模式支持 */
@media (prefers-color-scheme: dark) {
  .app-footer {
    background: rgba(255, 255, 255, 0.05);
    border-top-color: rgba(255, 255, 255, 0.1);
  }
  
  .footer-text {
    color: rgba(255, 255, 255, 0.7);
  }
}
</style>
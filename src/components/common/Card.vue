<template>
  <div :class="cardClasses" :style="cardStyle">
    <!-- 卡片头部 -->
    <div v-if="showHeader" class="card-header" :class="headerClasses">
      <slot name="header">
        <div v-if="title || subtitle" class="card-header-content">
          <h3 v-if="title" class="card-title">{{ title }}</h3>
          <p v-if="subtitle" class="card-subtitle">{{ subtitle }}</p>
        </div>
        <div v-if="showHeaderActions" class="card-header-actions">
          <slot name="header-actions"></slot>
        </div>
      </slot>
    </div>
    
    <!-- 卡片媒体（图片等） -->
    <div v-if="$slots.media" class="card-media">
      <slot name="media"></slot>
    </div>
    
    <!-- 卡片内容 -->
    <div class="card-body" :class="bodyClasses">
      <slot></slot>
    </div>
    
    <!-- 卡片底部 -->
    <div v-if="showFooter" class="card-footer" :class="footerClasses">
      <slot name="footer">
        <div v-if="footerText" class="card-footer-text">{{ footerText }}</div>
        <div v-if="showFooterActions" class="card-footer-actions">
          <slot name="footer-actions"></slot>
        </div>
      </slot>
    </div>
    
    <!-- 卡片加载状态 -->
    <div v-if="loading" class="card-loading">
      <div class="loading-spinner"></div>
      <span v-if="loadingText">{{ loadingText }}</span>
    </div>
    
    <!-- 卡片悬停效果层 -->
    <div v-if="hoverable" class="card-hover-layer"></div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  // 卡片变体
  variant: {
    type: String,
    default: 'default',
    validator: (value) => ['default', 'primary', 'secondary', 'success', 'warning', 'danger', 'info', 'dark', 'light'].includes(value)
  },
  
  // 卡片标题
  title: {
    type: String,
    default: ''
  },
  
  // 卡片副标题
  subtitle: {
    type: String,
    default: ''
  },
  
  // 是否显示头部
  showHeader: {
    type: Boolean,
    default: true
  },
  
  // 是否显示底部
  showFooter: {
    type: Boolean,
    default: false
  },
  
  // 底部文本
  footerText: {
    type: String,
    default: ''
  },
  
  // 是否显示头部操作区域
  showHeaderActions: {
    type: Boolean,
    default: false
  },
  
  // 是否显示底部操作区域
  showFooterActions: {
    type: Boolean,
    default: false
  },
  
  // 是否可悬停
  hoverable: {
    type: Boolean,
    default: false
  },
  
  // 是否可点击
  clickable: {
    type: Boolean,
    default: false
  },
  
  // 是否显示边框
  bordered: {
    type: Boolean,
    default: true
  },
  
  // 是否显示阴影
  shadow: {
    type: Boolean,
    default: true
  },
  
  // 阴影大小
  shadowSize: {
    type: String,
    default: 'md',
    validator: (value) => ['sm', 'md', 'lg', 'xl', 'none'].includes(value)
  },
  
  // 圆角大小
  borderRadius: {
    type: String,
    default: '12px'
  },
  
  // 加载状态
  loading: {
    type: Boolean,
    default: false
  },
  
  // 加载文本
  loadingText: {
    type: String,
    default: ''
  },
  
  // 卡片宽度
  width: {
    type: String,
    default: ''
  },
  
  // 卡片高度
  height: {
    type: String,
    default: ''
  },
  
  // 自定义类名
  customClass: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['click'])

// 卡片类名
const cardClasses = computed(() => {
  const classes = ['card']
  
  // 添加变体类
  if (props.variant !== 'default') {
    classes.push(`card-${props.variant}`)
  }
  
  // 添加状态类
  if (props.hoverable) classes.push('card-hoverable')
  if (props.clickable) classes.push('card-clickable')
  if (props.bordered) classes.push('card-bordered')
  if (props.loading) classes.push('card-loading')
  
  // 添加阴影类
  if (props.shadow && props.shadowSize !== 'none') {
    classes.push(`card-shadow-${props.shadowSize}`)
  }
  
  // 添加自定义类
  if (props.customClass) classes.push(props.customClass)
  
  return classes.join(' ')
})

// 卡片样式
const cardStyle = computed(() => {
  const style = {}
  
  if (props.borderRadius) {
    style.borderRadius = props.borderRadius
  }
  
  if (props.width) {
    style.width = props.width
  }
  
  if (props.height) {
    style.height = props.height
    style.overflow = 'auto'
  }
  
  return style
})

// 头部类名
const headerClasses = computed(() => {
  const classes = []
  if (props.variant !== 'default') {
    classes.push(`card-header-${props.variant}`)
  }
  return classes.join(' ')
})

// 内容区域类名
const bodyClasses = computed(() => {
  const classes = []
  if (props.variant !== 'default') {
    classes.push(`card-body-${props.variant}`)
  }
  return classes.join(' ')
})

// 底部类名
const footerClasses = computed(() => {
  const classes = []
  if (props.variant !== 'default') {
    classes.push(`card-footer-${props.variant}`)
  }
  return classes.join(' ')
})

// 处理点击事件
const handleClick = (event) => {
  if (props.clickable && !props.loading) {
    emit('click', event)
  }
}
</script>

<style scoped>
.card {
  position: relative;
  background: white;
  transition: all 0.3s ease;
  overflow: hidden;
}

/* 边框变体 */
.card-bordered {
  border: 1px solid #e9ecef;
}

/* 阴影变体 */
.card-shadow-sm {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card-shadow-md {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-shadow-lg {
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
}

.card-shadow-xl {
  box-shadow: 0 16px 32px rgba(0, 0, 0, 0.1);
}

/* 悬停效果 */
.card-hoverable:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
}

.card-clickable {
  cursor: pointer;
}

.card-clickable:active {
  transform: translateY(-1px);
}

/* 卡片头部 */
.card-header {
  padding: 1.25rem 1.5rem;
  border-bottom: 1px solid #e9ecef;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
}

.card-header-content {
  flex: 1;
}

.card-title {
  margin: 0;
  font-size: 1.25rem;
  font-weight: 600;
  color: #212529;
}

.card-subtitle {
  margin: 0.25rem 0 0;
  font-size: 0.95rem;
  color: #6c757d;
}

.card-header-actions {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

/* 卡片媒体 */
.card-media {
  overflow: hidden;
}

.card-media img {
  width: 100%;
  height: auto;
  display: block;
}

/* 卡片内容 */
.card-body {
  padding: 1.5rem;
}

/* 卡片底部 */
.card-footer {
  padding: 1rem 1.5rem;
  border-top: 1px solid #e9ecef;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
}

.card-footer-text {
  color: #6c757d;
  font-size: 0.9rem;
}

.card-footer-actions {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

/* 加载状态 */
.card-loading {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.9);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  z-index: 10;
  backdrop-filter: blur(2px);
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 3px solid rgba(102, 126, 234, 0.3);
  border-radius: 50%;
  border-top-color: #667eea;
  animation: spin 1s linear infinite;
}

/* 悬停效果层 */
.card-hover-layer {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
  opacity: 0;
  transition: opacity 0.3s ease;
  pointer-events: none;
}

.card-hoverable:hover .card-hover-layer {
  opacity: 1;
}

/* 颜色变体 */
.card-primary {
  border-color: #667eea;
}

.card-primary .card-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-bottom: none;
}

.card-primary .card-title {
  color: white;
}

.card-primary .card-subtitle {
  color: rgba(255, 255, 255, 0.8);
}

.card-secondary {
  border-color: #6c757d;
}

.card-secondary .card-header {
  background: #6c757d;
  color: white;
  border-bottom: none;
}

.card-success {
  border-color: #28a745;
}

.card-success .card-header {
  background: #28a745;
  color: white;
  border-bottom: none;
}

.card-warning {
  border-color: #ffc107;
}

.card-warning .card-header {
  background: #ffc107;
  color: #212529;
  border-bottom: none;
}

.card-danger {
  border-color: #dc3545;
}

.card-danger .card-header {
  background: #dc3545;
  color: white;
  border-bottom: none;
}

.card-info {
  border-color: #17a2b8;
}

.card-info .card-header {
  background: #17a2b8;
  color: white;
  border-bottom: none;
}

.card-dark {
  background: #343a40;
  color: white;
  border-color: #343a40;
}

.card-dark .card-header {
  background: #212529;
  color: white;
  border-bottom-color: #495057;
}

.card-dark .card-title {
  color: white;
}

.card-dark .card-subtitle {
  color: #adb5bd;
}

.card-dark .card-body {
  color: #e9ecef;
}

.card-dark .card-footer {
  border-top-color: #495057;
}

.card-dark .card-footer-text {
  color: #adb5bd;
}

.card-light {
  background: #f8f9fa;
  border-color: #f8f9fa;
}

/* 动画 */
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* 响应式调整 */
@media (max-width: 768px) {
  .card-header {
    padding: 1rem;
    flex-direction: column;
    align-items: flex-start;
    gap: 0.75rem;
  }
  
  .card-body {
    padding: 1rem;
  }
  
  .card-footer {
    padding: 0.75rem 1rem;
    flex-direction: column;
    align-items: flex-start;
    gap: 0.75rem;
  }
  
  .card-header-actions,
  .card-footer-actions {
    width: 100%;
    justify-content: flex-end;
  }
}

/* 深色模式支持 */
@media (prefers-color-scheme: dark) {
  .card:not(.card-dark):not(.card-light) {
    background: #2d3748;
    border-color: #4a5568;
  }
  
  .card:not(.card-dark):not(.card-light) .card-header {
    border-bottom-color: #4a5568;
  }
  
  .card:not(.card-dark):not(.card-light) .card-title {
    color: #e2e8f0;
  }
  
  .card:not(.card-dark):not(.card-light) .card-subtitle {
    color: #a0aec0;
  }
  
  .card:not(.card-dark):not(.card-light) .card-body {
    color: #cbd5e0;
  }
  
  .card:not(.card-dark):not(.card-light) .card-footer {
    border-top-color: #4a5568;
  }
  
  .card:not(.card-dark):not(.card-light) .card-footer-text {
    color: #a0aec0;
  }
  
  .card-loading {
    background: rgba(45, 55, 72, 0.9);
  }
}
</style>
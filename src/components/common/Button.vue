<template>
  <button
    :class="buttonClasses"
    :type="type"
    :disabled="disabled || loading"
    @click="handleClick"
    v-bind="$attrs"
  >
    <span v-if="loading" class="button-loading">
      <span class="loading-spinner"></span>
      <span v-if="loadingText">{{ loadingText }}</span>
      <span v-else>{{ label }}</span>
    </span>
    <span v-else class="button-content">
      <span v-if="icon" class="button-icon">{{ icon }}</span>
      <span v-if="label" class="button-label">{{ label }}</span>
      <slot v-else />
    </span>
  </button>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  // 按钮类型
  variant: {
    type: String,
    default: 'primary',
    validator: (value) => ['primary', 'secondary', 'outline', 'ghost', 'danger', 'success', 'warning'].includes(value)
  },
  
  // 按钮尺寸
  size: {
    type: String,
    default: 'medium',
    validator: (value) => ['small', 'medium', 'large', 'xlarge'].includes(value)
  },
  
  // 是否块级元素
  block: {
    type: Boolean,
    default: false
  },
  
  // 是否圆角
  rounded: {
    type: Boolean,
    default: false
  },
  
  // 加载状态
  loading: {
    type: Boolean,
    default: false
  },
  
  // 加载时显示的文字
  loadingText: {
    type: String,
    default: ''
  },
  
  // 禁用状态
  disabled: {
    type: Boolean,
    default: false
  },
  
  // 按钮文字
  label: {
    type: String,
    default: ''
  },
  
  // 图标（emoji或图标类名）
  icon: {
    type: String,
    default: ''
  },
  
  // 按钮类型
  type: {
    type: String,
    default: 'button'
  }
})

const emit = defineEmits(['click'])

// 计算按钮类名
const buttonClasses = computed(() => {
  const classes = ['btn']
  
  // 添加变体类
  classes.push(`btn-${props.variant}`)
  
  // 添加尺寸类
  classes.push(`btn-${props.size}`)
  
  // 添加其他状态类
  if (props.block) classes.push('btn-block')
  if (props.rounded) classes.push('btn-rounded')
  if (props.loading) classes.push('btn-loading')
  if (props.disabled) classes.push('btn-disabled')
  
  return classes.join(' ')
})

// 处理点击事件
const handleClick = (event) => {
  if (!props.loading && !props.disabled) {
    emit('click', event)
  }
}
</script>

<style scoped>
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  font-family: inherit;
  text-decoration: none;
  white-space: nowrap;
  user-select: none;
  position: relative;
  overflow: hidden;
}

/* 尺寸 */
.btn-small {
  padding: 0.4rem 0.8rem;
  font-size: 0.875rem;
  min-height: 32px;
}

.btn-medium {
  padding: 0.6rem 1.2rem;
  font-size: 1rem;
  min-height: 40px;
}

.btn-large {
  padding: 0.8rem 1.6rem;
  font-size: 1.125rem;
  min-height: 48px;
}

.btn-xlarge {
  padding: 1rem 2rem;
  font-size: 1.25rem;
  min-height: 56px;
}

/* 变体 */
.btn-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
}

.btn-primary:hover:not(.btn-disabled):not(.btn-loading) {
  transform: translateY(-2px);
  box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
}

.btn-primary:active:not(.btn-disabled):not(.btn-loading) {
  transform: translateY(0);
}

.btn-secondary {
  background: #6c757d;
  color: white;
  border: none;
}

.btn-secondary:hover:not(.btn-disabled):not(.btn-loading) {
  background: #5a6268;
  transform: translateY(-2px);
}

.btn-outline {
  background: transparent;
  color: #667eea;
  border: 2px solid #667eea;
}

.btn-outline:hover:not(.btn-disabled):not(.btn-loading) {
  background: #667eea;
  color: white;
}

.btn-ghost {
  background: transparent;
  color: #495057;
  border: 1px solid transparent;
}

.btn-ghost:hover:not(.btn-disabled):not(.btn-loading) {
  background: #f8f9fa;
  border-color: #dee2e6;
}

.btn-danger {
  background: #dc3545;
  color: white;
  border: none;
}

.btn-danger:hover:not(.btn-disabled):not(.btn-loading) {
  background: #c82333;
  transform: translateY(-2px);
}

.btn-success {
  background: #28a745;
  color: white;
  border: none;
}

.btn-success:hover:not(.btn-disabled):not(.btn-loading) {
  background: #218838;
  transform: translateY(-2px);
}

.btn-warning {
  background: #ffc107;
  color: #212529;
  border: none;
}

.btn-warning:hover:not(.btn-disabled):not(.btn-loading) {
  background: #e0a800;
  transform: translateY(-2px);
}

/* 块级按钮 */
.btn-block {
  display: flex;
  width: 100%;
}

/* 圆角按钮 */
.btn-rounded {
  border-radius: 50px;
}

/* 禁用状态 */
.btn-disabled,
.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none !important;
  box-shadow: none !important;
}

/* 加载状态 */
.btn-loading {
  cursor: wait;
  opacity: 0.8;
}

.button-loading {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.loading-spinner {
  width: 16px;
  height: 16px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 50%;
  border-top-color: white;
  animation: spin 1s linear infinite;
}

.btn-outline .loading-spinner,
.btn-ghost .loading-spinner {
  border-top-color: #667eea;
}

.btn-outline.btn-loading:hover .loading-spinner,
.btn-ghost.btn-loading:hover .loading-spinner {
  border-top-color: white;
}

/* 按钮内容 */
.button-content {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.button-icon {
  font-size: 1.2em;
  line-height: 1;
}

/* 动画 */
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* 涟漪效果 */
.btn::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 5px;
  height: 5px;
  background: rgba(255, 255, 255, 0.5);
  opacity: 0;
  border-radius: 100%;
  transform: scale(1, 1) translate(-50%);
  transform-origin: 50% 50%;
}

.btn:focus:not(:active)::after {
  animation: ripple 1s ease-out;
}

@keyframes ripple {
  0% {
    transform: scale(0, 0);
    opacity: 0.5;
  }
  20% {
    transform: scale(25, 25);
    opacity: 0.3;
  }
  100% {
    opacity: 0;
    transform: scale(40, 40);
  }
}

/* 响应式调整 */
@media (max-width: 768px) {
  .btn-medium {
    padding: 0.5rem 1rem;
    font-size: 0.95rem;
  }
  
  .btn-large {
    padding: 0.7rem 1.4rem;
    font-size: 1.05rem;
  }
}
</style>
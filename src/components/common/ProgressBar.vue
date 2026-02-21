<template>
  <div class="progress-container" :class="containerClasses">
    <!-- 标签区域 -->
    <div v-if="showLabel" class="progress-label">
      <span class="label-text">{{ label }}</span>
      <span v-if="showPercentage" class="percentage">{{ percentage }}%</span>
    </div>
    
    <!-- 进度条轨道 -->
    <div class="progress-track" :style="trackStyle">
      <!-- 进度条填充 -->
      <div 
        class="progress-fill" 
        :class="fillClasses"
        :style="fillStyle"
      >
        <!-- 条纹动画 -->
        <div v-if="striped" class="progress-stripes"></div>
        
        <!-- 进度文本（在进度条内） -->
        <span v-if="showInnerText" class="inner-text">
          {{ innerText }}
        </span>
      </div>
      
      <!-- 进度标记点 -->
      <div 
        v-for="mark in marks" 
        :key="mark.value"
        class="progress-mark"
        :style="{ left: `${mark.value}%` }"
        :title="mark.label || `${mark.value}%`"
      ></div>
    </div>
    
    <!-- 底部信息 -->
    <div v-if="showInfo" class="progress-info">
      <slot name="info">
        <span v-if="infoText">{{ infoText }}</span>
        <span v-else>进度: {{ current }}/{{ max }}</span>
      </slot>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  // 当前值
  value: {
    type: Number,
    default: 0,
    validator: (value) => value >= 0
  },
  
  // 最大值
  max: {
    type: Number,
    default: 100,
    validator: (value) => value > 0
  },
  
  // 进度条高度
  height: {
    type: String,
    default: '12px'
  },
  
  // 进度条颜色
  color: {
    type: String,
    default: 'primary'
  },
  
  // 是否显示条纹
  striped: {
    type: Boolean,
    default: false
  },
  
  // 是否显示动画
  animated: {
    type: Boolean,
    default: false
  },
  
  // 是否显示标签
  showLabel: {
    type: Boolean,
    default: true
  },
  
  // 标签文本
  label: {
    type: String,
    default: '进度'
  },
  
  // 是否显示百分比
  showPercentage: {
    type: Boolean,
    default: true
  },
  
  // 是否显示内部文本
  showInnerText: {
    type: Boolean,
    default: false
  },
  
  // 内部文本
  innerText: {
    type: String,
    default: ''
  },
  
  // 是否显示底部信息
  showInfo: {
    type: Boolean,
    default: false
  },
  
  // 底部信息文本
  infoText: {
    type: String,
    default: ''
  },
  
  // 圆角大小
  borderRadius: {
    type: String,
    default: '50px'
  },
  
  // 标记点
  marks: {
    type: Array,
    default: () => []
  },
  
  // 自定义类名
  customClass: {
    type: String,
    default: ''
  }
})

// 计算当前进度百分比
const percentage = computed(() => {
  const percent = (props.value / props.max) * 100
  return Math.min(Math.max(percent, 0), 100).toFixed(1)
})

// 计算当前值（确保在范围内）
const current = computed(() => {
  return Math.min(Math.max(props.value, 0), props.max)
})

// 容器类名
const containerClasses = computed(() => {
  const classes = []
  if (props.customClass) classes.push(props.customClass)
  if (props.striped) classes.push('progress-striped')
  if (props.animated) classes.push('progress-animated')
  return classes.join(' ')
})

// 填充条类名
const fillClasses = computed(() => {
  const classes = ['progress-fill']
  classes.push(`progress-${props.color}`)
  if (props.striped) classes.push('striped')
  if (props.animated) classes.push('animated')
  return classes.join(' ')
})

// 轨道样式
const trackStyle = computed(() => {
  return {
    height: props.height,
    borderRadius: props.borderRadius
  }
})

// 填充条样式
const fillStyle = computed(() => {
  return {
    width: `${percentage.value}%`,
    borderRadius: props.borderRadius
  }
})
</script>

<style scoped>
.progress-container {
  width: 100%;
  margin: 1rem 0;
}

.progress-label {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
  font-size: 0.95rem;
}

.label-text {
  font-weight: 600;
  color: #495057;
}

.percentage {
  font-weight: 600;
  color: #667eea;
  font-size: 0.9rem;
}

.progress-track {
  position: relative;
  width: 100%;
  background: #e9ecef;
  overflow: hidden;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
}

.progress-fill {
  position: relative;
  height: 100%;
  transition: width 0.6s ease;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding-right: 0.5rem;
  box-sizing: border-box;
}

/* 颜色变体 */
.progress-primary {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.progress-success {
  background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
}

.progress-warning {
  background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
}

.progress-danger {
  background: linear-gradient(135deg, #dc3545 0%, #e83e8c 100%);
}

.progress-info {
  background: linear-gradient(135deg, #17a2b8 0%, #0dcaf0 100%);
}

/* 条纹效果 */
.progress-striped .progress-fill {
  background-size: 30px 30px;
}

.progress-striped .progress-fill.striped::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: linear-gradient(
    45deg,
    rgba(255, 255, 255, 0.15) 25%,
    transparent 25%,
    transparent 50%,
    rgba(255, 255, 255, 0.15) 50%,
    rgba(255, 255, 255, 0.15) 75%,
    transparent 75%,
    transparent
  );
  background-size: 30px 30px;
}

/* 动画效果 */
.progress-animated .progress-fill.animated::before {
  animation: progress-stripes 1s linear infinite;
}

@keyframes progress-stripes {
  0% {
    background-position: 0 0;
  }
  100% {
    background-position: 30px 0;
  }
}

/* 内部文本 */
.inner-text {
  color: white;
  font-size: 0.75rem;
  font-weight: 600;
  text-shadow: 0 1px 1px rgba(0, 0, 0, 0.3);
  padding: 0 0.5rem;
  white-space: nowrap;
}

/* 标记点 */
.progress-mark {
  position: absolute;
  top: 50%;
  transform: translate(-50%, -50%);
  width: 6px;
  height: 6px;
  background: white;
  border: 2px solid #495057;
  border-radius: 50%;
  z-index: 2;
  cursor: help;
}

.progress-mark:hover::after {
  content: attr(title);
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  background: #495057;
  color: white;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  font-size: 0.75rem;
  white-space: nowrap;
  margin-bottom: 0.5rem;
  z-index: 10;
}

/* 底部信息 */
.progress-info {
  margin-top: 0.5rem;
  font-size: 0.85rem;
  color: #6c757d;
  text-align: right;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .progress-label {
    font-size: 0.9rem;
  }
  
  .inner-text {
    font-size: 0.7rem;
    padding: 0 0.3rem;
  }
}

/* 深色模式支持 */
@media (prefers-color-scheme: dark) {
  .progress-track {
    background: #343a40;
  }
  
  .label-text {
    color: #e9ecef;
  }
  
  .progress-mark {
    border-color: #adb5bd;
  }
  
  .progress-info {
    color: #adb5bd;
  }
}
</style>
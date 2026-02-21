<template>
  <div class="stage-nav" :class="navClasses">
    <!-- 进度条 -->
    <div v-if="showProgress" class="stage-progress">
      <ProgressBar
        :value="currentStage"
        :max="totalStages"
        :height="progressHeight"
        :color="progressColor"
        :striped="progressStriped"
        :animated="progressAnimated"
        :show-label="false"
        :show-info="false"
        :marks="stageMarks"
      />
      <div class="stage-progress-text">
        <span>阶段 {{ currentStage }} / {{ totalStages }}</span>
        <span>{{ progressPercentage }}% 完成</span>
      </div>
    </div>
    
    <!-- 阶段导航按钮 -->
    <div class="stage-buttons">
      <button
        v-for="stage in stages"
        :key="stage.id"
        :class="stageButtonClasses(stage)"
        @click="handleStageClick(stage)"
        :disabled="!stage.available"
        :title="stage.title"
      >
        <div class="stage-button-content">
          <!-- 阶段编号 -->
          <div class="stage-number">
            {{ stage.id }}
            <span v-if="stage.completed" class="stage-completed-icon">✓</span>
          </div>
          
          <!-- 阶段标题 -->
          <div class="stage-title">{{ stage.title }}</div>
          
          <!-- 阶段状态 -->
          <div class="stage-status">
            <span v-if="stage.completed" class="status-completed">已完成</span>
            <span v-else-if="stage.current" class="status-current">进行中</span>
            <span v-else-if="stage.available" class="status-available">可访问</span>
            <span v-else class="status-locked">已锁定</span>
          </div>
        </div>
        
        <!-- 阶段描述（悬停时显示） -->
        <div class="stage-description-tooltip">
          {{ stage.description }}
        </div>
      </button>
    </div>
    
    <!-- 导航控制按钮 -->
    <div v-if="showControls" class="stage-controls">
      <Button
        variant="outline"
        size="small"
        :disabled="!canGoPrev"
        @click="handlePrev"
        icon="←"
        label="上一阶段"
      />
      
      <div class="stage-controls-info">
        <span v-if="currentStageData" class="current-stage-title">
          {{ currentStageData.title }}
        </span>
        <span class="stage-questions-count">
          {{ currentStageData?.questions?.length || 0 }} 个问题
        </span>
      </div>
      
      <Button
        :variant="canGoNext ? 'primary' : 'outline'"
        size="small"
        :disabled="!canGoNext"
        @click="handleNext"
        :icon="isLastStage ? '✓' : '→'"
        :label="isLastStage ? '完成访谈' : '下一阶段'"
      />
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import ProgressBar from '@/components/common/ProgressBar.vue'
import Button from '@/components/common/Button.vue'

const props = defineProps({
  // 阶段数据
  stages: {
    type: Array,
    required: true,
    default: () => []
  },
  
  // 当前阶段ID
  currentStage: {
    type: Number,
    required: true,
    default: 1
  },
  
  // 是否显示进度条
  showProgress: {
    type: Boolean,
    default: true
  },
  
  // 进度条高度
  progressHeight: {
    type: String,
    default: '8px'
  },
  
  // 进度条颜色
  progressColor: {
    type: String,
    default: 'primary'
  },
  
  // 进度条是否显示条纹
  progressStriped: {
    type: Boolean,
    default: true
  },
  
  // 进度条是否显示动画
  progressAnimated: {
    type: Boolean,
    default: true
  },
  
  // 是否显示导航控制
  showControls: {
    type: Boolean,
    default: true
  },
  
  // 导航方向
  direction: {
    type: String,
    default: 'horizontal',
    validator: (value) => ['horizontal', 'vertical'].includes(value)
  },
  
  // 是否紧凑模式
  compact: {
    type: Boolean,
    default: false
  },
  
  // 自定义类名
  customClass: {
    type: String,
    default: ''
  }
})

const emit = defineEmits(['stage-change', 'prev', 'next', 'complete'])

// 计算属性
const totalStages = computed(() => props.stages.length)

const progressPercentage = computed(() => {
  return ((props.currentStage - 1) / totalStages.value * 100).toFixed(0)
})

const stageMarks = computed(() => {
  return props.stages.map(stage => ({
    value: ((stage.id - 1) / totalStages.value * 100),
    label: `阶段 ${stage.id}: ${stage.title}`
  }))
})

const currentStageData = computed(() => {
  return props.stages.find(stage => stage.id === props.currentStage)
})

const canGoPrev = computed(() => {
  return props.currentStage > 1
})

const canGoNext = computed(() => {
  const currentStage = props.stages.find(stage => stage.id === props.currentStage)
  return currentStage?.completed || false
})

const isLastStage = computed(() => {
  return props.currentStage === totalStages.value
})

const navClasses = computed(() => {
  const classes = ['stage-nav']
  classes.push(`stage-nav-${props.direction}`)
  if (props.compact) classes.push('stage-nav-compact')
  if (props.customClass) classes.push(props.customClass)
  return classes.join(' ')
})

// 方法
const stageButtonClasses = (stage) => {
  const classes = ['stage-button']
  
  if (stage.current) classes.push('stage-button-current')
  if (stage.completed) classes.push('stage-button-completed')
  if (stage.available) classes.push('stage-button-available')
  if (!stage.available) classes.push('stage-button-locked')
  if (stage.id === props.currentStage) classes.push('stage-button-active')
  
  return classes.join(' ')
}

const handleStageClick = (stage) => {
  if (stage.available && stage.id !== props.currentStage) {
    emit('stage-change', stage.id)
  }
}

const handlePrev = () => {
  if (canGoPrev.value) {
    emit('prev')
  }
}

const handleNext = () => {
  if (canGoNext.value) {
    if (isLastStage.value) {
      emit('complete')
    } else {
      emit('next')
    }
  }
}
</script>

<style scoped>
.stage-nav {
  width: 100%;
}

/* 水平布局 */
.stage-nav-horizontal {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

/* 垂直布局 */
.stage-nav-vertical {
  display: flex;
  flex-direction: row;
  gap: 1rem;
}

.stage-nav-vertical .stage-buttons {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  min-width: 200px;
}

.stage-nav-vertical .stage-progress {
  display: none;
}

.stage-nav-vertical .stage-controls {
  flex: 1;
  flex-direction: column;
  align-items: flex-start;
}

/* 进度条区域 */
.stage-progress {
  margin-bottom: 1rem;
}

.stage-progress-text {
  display: flex;
  justify-content: space-between;
  margin-top: 0.5rem;
  font-size: 0.9rem;
  color: #6c757d;
}

/* 阶段按钮区域 */
.stage-buttons {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 1rem;
}

.stage-nav-compact .stage-buttons {
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 0.75rem;
}

/* 阶段按钮 */
.stage-button {
  position: relative;
  background: white;
  border: 2px solid #e9ecef;
  border-radius: 12px;
  padding: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  text-align: center;
  user-select: none;
  overflow: hidden;
}

.stage-button:hover:not(.stage-button-locked) {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.stage-button:active:not(.stage-button-locked) {
  transform: translateY(0);
}

/* 按钮状态 */
.stage-button-current {
  border-color: #667eea;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
}

.stage-button-completed {
  border-color: #28a745;
  background: linear-gradient(135deg, rgba(40, 167, 69, 0.1) 0%, rgba(32, 201, 151, 0.1) 100%);
}

.stage-button-available:not(.stage-button-current):not(.stage-button-completed) {
  border-color: #6c757d;
}

.stage-button-locked {
  border-color: #dee2e6;
  background: #f8f9fa;
  cursor: not-allowed;
  opacity: 0.7;
}

.stage-button-active {
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
}

/* 按钮内容 */
.stage-button-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  position: relative;
  z-index: 2;
}

.stage-number {
  width: 36px;
  height: 36px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.1rem;
  font-weight: bold;
  position: relative;
}

.stage-button-completed .stage-number {
  background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
}

.stage-button-locked .stage-number {
  background: #adb5bd;
}

.stage-completed-icon {
  position: absolute;
  top: -4px;
  right: -4px;
  background: white;
  color: #28a745;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.7rem;
  font-weight: bold;
  border: 2px solid #28a745;
}

.stage-title {
  font-weight: 600;
  color: #212529;
  font-size: 0.95rem;
  line-height: 1.2;
}

.stage-button-locked .stage-title {
  color: #6c757d;
}

.stage-status {
  font-size: 0.8rem;
  padding: 0.2rem 0.5rem;
  border-radius: 10px;
  font-weight: 500;
}

.status-completed {
  background: #d4edda;
  color: #155724;
}

.status-current {
  background: #d1ecf1;
  color: #0c5460;
}

.status-available {
  background: #f8f9fa;
  color: #6c757d;
}

.status-locked {
  background: #f8f9fa;
  color: #adb5bd;
}

/* 描述工具提示 */
.stage-description-tooltip {
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  background: #343a40;
  color: white;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  font-size: 0.85rem;
  line-height: 1.4;
  width: 250px;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  z-index: 100;
  margin-top: 0.5rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  pointer-events: none;
}

.stage-description-tooltip::before {
  content: '';
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  border: 6px solid transparent;
  border-bottom-color: #343a40;
}

.stage-button:hover .stage-description-tooltip {
  opacity: 1;
  visibility: visible;
  margin-top: 0.75rem;
}

/* 导航控制 */
.stage-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
  margin-top: 1.5rem;
  padding-top: 1.5rem;
  border-top: 1px solid #e9ecef;
}

.stage-controls-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;
  flex: 1;
}

.current-stage-title {
  font-weight: 600;
  color: #212529;
  font-size: 1.1rem;
}

.stage-questions-count {
  font-size: 0.9rem;
  color: #6c757d;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .stage-buttons {
    grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
    gap: 0.75rem;
  }
  
  .stage-nav-compact .stage-buttons {
    grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  }
  
  .stage-button {
    padding: 0.75rem;
  }
  
  .stage-title {
    font-size: 0.85rem;
  }
  
  .stage-controls {
    flex-direction: column;
    gap: 1rem;
  }
  
  .stage-controls-info {
    order: -1;
    width: 100%;
    text-align: center;
  }
  
  .stage-description-tooltip {
    display: none;
  }
}

/* 深色模式支持 */
@media (prefers-color-scheme: dark) {
  .stage-button {
    background: #2d3748;
    border-color: #4a5568;
  }
  
  .stage-button-locked {
    background: #1a202c;
    border-color: #2d3748;
  }
  
  .stage-title {
    color: #e2e8f0;
  }
  
  .stage-button-locked .stage-title {
    color: #a0aec0;
  }
  
  .stage-progress-text {
    color: #a0aec0;
  }
  
  .stage-controls {
    border-top-color: #4a5568;
  }
  
  .current-stage-title {
    color: #e2e8f0;
  }
  
  .stage-questions-count {
    color: #a0aec0;
  }
  
  .status-completed {
    background: rgba(40, 167, 69, 0.2);
    color: #9ae6b4;
  }
  
  .status-current {
    background: rgba(23, 162, 184, 0.2);
    color: #90cdf4;
  }
  
  .status-available {
    background: rgba(160, 174, 192, 0.2);
    color: #cbd5e0;
  }
  
  .status-locked {
    background: rgba(74, 85, 104, 0.2);
    color: #a0aec0;
  }
}
</style>
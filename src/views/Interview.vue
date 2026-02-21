<template>
  <div class="interview">
    <!-- 简洁的进度指示器 -->
    <div class="progress-container">
      <div class="progress-info">
        <span class="step-counter">步骤 {{ currentStep }} / {{ totalSteps }}</span>
        <span class="step-title">{{ currentStepData.title }}</span>
      </div>
      
      <div class="progress-bar">
        <div 
          class="progress-fill"
          :style="{ width: `${(currentStep / totalSteps) * 100}%` }"
        ></div>
      </div>
    </div>
    
    <!-- 主要内容区域 -->
    <main class="interview-content">
      <div class="step-content">
        <!-- 步骤说明 -->
        <div class="step-description">
          <h1 class="step-question">{{ currentStepData.question }}</h1>
          <p class="step-hint" v-if="currentStepData.hint">{{ currentStepData.hint }}</p>
        </div>
        
        <!-- 回答区域 -->
        <div class="answer-area">
          <textarea
            v-model="answers[currentStep - 1]"
            :placeholder="currentStepData.placeholder"
            class="answer-input"
            rows="8"
            @input="saveAnswer"
            autofocus
          ></textarea>
          
          <!-- 提示信息 -->
          <div class="tips-section" v-if="currentStepData.tips">
            <div class="tips-content">
              <span class="tips-icon">💡</span>
              <span>{{ currentStepData.tips }}</span>
            </div>
          </div>
        </div>
        
        <!-- 导航按钮 -->
        <div class="navigation-buttons">
          <!-- 返回按钮 -->
          <button 
            class="nav-button back-button"
            @click="goBack"
            v-if="currentStep > 1"
          >
            ← 返回上一步
          </button>
          
          <!-- 跳过按钮 -->
          <button 
            class="nav-button skip-button"
            @click="skipQuestion"
            v-if="currentStepData.allowSkip && !answers[currentStep - 1]"
          >
            跳过此问题
          </button>
          
          <!-- 下一步/完成按钮 -->
          <button 
            class="nav-button next-button"
            @click="nextStep"
            :disabled="!currentStepData.allowSkip && !answers[currentStep - 1]"
          >
            <span v-if="currentStep < totalSteps">
              下一步 →
            </span>
            <span v-else>
              完成访谈 ✨
            </span>
          </button>
        </div>
      </div>
    </main>
    
    <!-- 底部信息 -->
    <footer class="interview-footer">
      <p class="footer-text">
        你的回答会自动保存，可以随时返回修改。
        <span class="privacy-note">我们不会保存任何个人身份信息。</span>
      </p>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// 访谈步骤数据 - 保持原有的完整问题
const steps = [
  {
    id: 1,
    title: '现状评估',
    question: '请描述你当前的生活状态。你对哪些方面感到满意，哪些方面希望改进？',
    hint: '可以从工作、健康、人际关系、个人成长等方面思考',
    placeholder: '例如：我对当前的工作比较满意，但感觉缺乏个人成长空间。健康方面需要改善，经常熬夜...',
    tips: '诚实面对自己，这是重新设计生活的第一步。',
    allowSkip: false
  },
  {
    id: 2,
    title: '价值观澄清',
    question: '对你来说，生活中最重要的是什么？请列出3-5个核心价值观。',
    hint: '例如：家庭、健康、自由、成长、贡献、冒险等',
    placeholder: '1. 健康 - 身体和心理的健康是基础\n2. 成长 - 持续学习和进步\n3. 自由 - 时间和选择的自由...',
    tips: '价值观是你做决策的指南针，明确它们很重要。',
    allowSkip: true
  },
  {
    id: 3,
    title: '愿景构建',
    question: '想象一下，3年后的理想生活是什么样子？请具体描述。',
    hint: '越具体越好，包括生活、工作、人际关系、个人状态等',
    placeholder: '3年后，我希望：\n- 拥有一份有意义的工作，每天充满激情\n- 保持健康的生活方式，每周运动3次\n- 与家人朋友关系更加亲密...',
    tips: '愿景是你前进的方向，大胆想象，不要设限。',
    allowSkip: false
  },
  {
    id: 4,
    title: '障碍分析',
    question: '在实现理想生活的过程中，你可能会遇到哪些障碍或挑战？',
    hint: '包括外部障碍（时间、资源、环境）和内部障碍（习惯、信念、恐惧）',
    placeholder: '可能的障碍：\n1. 时间管理 - 工作繁忙，缺乏个人时间\n2. 习惯难改 - 熬夜、拖延等坏习惯\n3. 资源限制 - 资金、技能不足...',
    tips: '识别障碍是解决问题的第一步，不要回避它们。',
    allowSkip: true
  },
  {
    id: 5,
    title: '行动计划',
    question: '基于以上分析，你可以采取哪些具体行动来开始改变？',
    hint: '从小处着手，制定可行的第一步',
    placeholder: '例如：\n1. 本周开始，每天早睡30分钟\n2. 报名参加一个在线课程，提升技能\n3. 每周安排2小时与家人深度交流...',
    tips: '行动是改变的唯一途径，从小步骤开始，持续前进。',
    allowSkip: false
  }
]

// 响应式数据
const currentStep = ref(1)
const answers = ref(Array(steps.length).fill(''))

// 计算属性
const totalSteps = computed(() => steps.length)
const currentStepData = computed(() => steps[currentStep.value - 1])

// 方法
const saveAnswer = () => {
  localStorage.setItem('life-reset-answers', JSON.stringify(answers.value))
}

const loadAnswers = () => {
  const saved = localStorage.getItem('life-reset-answers')
  if (saved) {
    answers.value = JSON.parse(saved)
  }
}

const nextStep = () => {
  if (currentStep.value < totalSteps.value) {
    currentStep.value++
  } else {
    completeInterview()
  }
}

const prevStep = () => {
  if (currentStep.value > 1) {
    currentStep.value--
  }
}

const skipQuestion = () => {
  if (!answers.value[currentStep.value - 1]) {
    answers.value[currentStep.value - 1] = '我选择跳过这个问题。'
  }
  nextStep()
}

const goBack = () => {
  if (currentStep.value === 1) {
    router.push('/')
  } else {
    prevStep()
  }
}

const completeInterview = () => {
  saveAnswer()
  alert('恭喜！你已完成人生重置访谈。下一步将为你生成个性化的人生重置地图。')
  router.push('/map')
}

// 生命周期
onMounted(() => {
  loadAnswers()
})
</script>

<style scoped>
.interview {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  display: flex;
  flex-direction: column;
}

/* 进度指示器 */
.progress-container {
  padding: 1.5rem 1rem 0;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
}

.progress-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.75rem;
}

.step-counter {
  font-size: 0.95rem;
  opacity: 0.9;
  font-weight: 500;
}

.step-title {
  font-size: 1.1rem;
  font-weight: 600;
}

.progress-bar {
  height: 6px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 3px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: white;
  border-radius: 3px;
  transition: width 0.3s ease;
}

/* 主要内容区域 */
.interview-content {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem 1rem;
}

.step-content {
  max-width: 800px;
  width: 100%;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  padding: 2.5rem;
}

/* 步骤说明 */
.step-description {
  margin-bottom: 2.5rem;
  text-align: center;
}

.step-question {
  font-size: 2.2rem;
  font-weight: 700;
  line-height: 1.3;
  margin-bottom: 1rem;
  color: white;
}

.step-hint {
  font-size: 1.2rem;
  opacity: 0.9;
  line-height: 1.5;
}

/* 回答区域 */
.answer-area {
  margin-bottom: 2.5rem;
}

.answer-input {
  width: 100%;
  padding: 1.5rem;
  font-size: 1.1rem;
  line-height: 1.6;
  background: rgba(255, 255, 255, 0.15);
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 12px;
  color: white;
  resize: vertical;
  transition: all 0.3s ease;
  font-family: inherit;
}

.answer-input:focus {
  outline: none;
  border-color: white;
  background: rgba(255, 255, 255, 0.2);
  box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
}

.answer-input::placeholder {
  color: rgba(255, 255, 255, 0.6);
}

/* 提示信息 */
.tips-section {
  margin-top: 1.5rem;
  padding: 1rem 1.25rem;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  border-left: 4px solid #ffc107;
}

.tips-content {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  font-size: 1rem;
  opacity: 0.9;
  line-height: 1.5;
}

.tips-icon {
  font-size: 1.2rem;
  flex-shrink: 0;
}

/* 导航按钮 */
.navigation-buttons {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.nav-button {
  flex: 1;
  min-width: 120px;
  padding: 1rem 1.5rem;
  font-size: 1.1rem;
  font-weight: 600;
  border: none;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-align: center;
}

.back-button {
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.back-button:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.5);
}

.skip-button {
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.skip-button:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.5);
}

.next-button {
  background: white;
  color: #667eea;
  border: none;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.next-button:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
}

.next-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* 底部信息 */
.interview-footer {
  padding: 1.5rem;
  text-align: center;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}

.footer-text {
  font-size: 0.95rem;
  opacity: 0.8;
  line-height: 1.5;
}

.privacy-note {
  color: #4ade80;
  font-weight: 500;
  opacity: 1;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .step-content {
    padding: 1.5rem;
  }
  
  .step-question {
    font-size: 1.8rem;
  }
  
  .step-hint {
    font-size: 1.1rem;
  }
  
  .answer-input {
    padding: 1.25rem;
    font-size: 1rem;
  }
  
  .navigation-buttons {
    flex-direction: column;
  }
  
  .nav-button {
    width: 100%;
  }
  
  .progress-info {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
  
  .step-title {
    font-size: 1rem;
  }
}

/* 深色模式优化 */
@media (prefers-color-scheme: dark) {
  .interview {
    background: linear-gradient(135deg, #4c51bf 0%, #6b46c1 100%);
  }
  
  .answer-input {
    background: rgba(255, 255, 255, 0.08);
  }
  
  .tips-section {
    background: rgba(255, 255, 255, 0.08);
  }
}
</style>
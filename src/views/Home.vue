<template>
  <div class="home">
    <!-- 主内容区域 - 单色背景，专注于CTA -->
    <main class="main-content">
      <div class="content-wrapper">
        <!-- 简洁的标题 -->
        <div class="title-section">
          <h1 class="main-title">人生重置向导</h1>
          <p class="main-subtitle">重新设计你想要的生活，从今天开始</p>
        </div>
        
        <!-- 核心价值主张 -->
        <div class="value-proposition">
          <p class="value-text">通过五个简单步骤，系统化地重新设计你的人生</p>
        </div>
        
        <!-- 超显眼的CTA按钮 -->
        <div class="cta-section">
          <button 
            class="primary-cta"
            @click="startInterview"
          >
            <span class="cta-icon">✨</span>
            <span class="cta-text">开始免费人生重置</span>
            <span class="cta-arrow">→</span>
          </button>
          
          <p class="cta-note">完全免费 · 隐私保护 · 15-20分钟完成</p>
        </div>
        
        <!-- 简化的步骤预览 -->
        <div class="steps-preview">
          <h2 class="steps-title">五个简单步骤</h2>
          
          <div class="steps-grid">
            <div class="step-card" v-for="step in steps" :key="step.id">
              <div class="step-header">
                <span class="step-number">{{ step.id }}</span>
                <h3 class="step-title">{{ step.title }}</h3>
              </div>
              <p class="step-description">{{ step.description }}</p>
            </div>
          </div>
          
          <!-- 次要CTA -->
          <button 
            class="secondary-cta"
            @click="startInterview"
          >
            立即开始第一步 →
          </button>
        </div>
        
        <!-- 简单的信任提示 -->
        <div class="trust-note">
          <p>已帮助 <strong>1,000+</strong> 人重新设计他们的人生</p>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const steps = [
  {
    id: 1,
    title: '现状评估',
    description: '了解当前的生活状态和满意度'
  },
  {
    id: 2,
    title: '价值观澄清',
    description: '明确对你最重要的核心价值观'
  },
  {
    id: 3,
    title: '愿景构建',
    description: '描绘理想生活的具体画面'
  },
  {
    id: 4,
    title: '障碍分析',
    description: '识别可能遇到的困难和挑战'
  },
  {
    id: 5,
    title: '行动计划',
    description: '制定具体可行的步骤和时间表'
  }
]

const startInterview = () => {
  router.push('/interview')
}
</script>

<style scoped>
.home {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.main-content {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem 1rem;
}

.content-wrapper {
  max-width: 800px;
  width: 100%;
  text-align: center;
}

/* 标题区域 */
.title-section {
  margin-bottom: 2.5rem;
}

.main-title {
  font-size: 3.5rem;
  font-weight: 800;
  margin-bottom: 0.75rem;
  line-height: 1.1;
  background: linear-gradient(135deg, #ffffff 0%, #e2e8f0 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.main-subtitle {
  font-size: 1.5rem;
  opacity: 0.9;
  line-height: 1.4;
}

/* 价值主张 */
.value-proposition {
  margin-bottom: 3rem;
}

.value-text {
  font-size: 1.3rem;
  opacity: 0.85;
  line-height: 1.5;
}

/* 主要CTA按钮 */
.cta-section {
  margin-bottom: 4rem;
}

.primary-cta {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  padding: 1.5rem 3rem;
  font-size: 1.5rem;
  font-weight: 700;
  color: #667eea;
  background: white;
  border: none;
  border-radius: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 
    0 10px 30px rgba(0, 0, 0, 0.3),
    0 0 0 4px rgba(255, 255, 255, 0.1),
    0 0 0 8px rgba(255, 255, 255, 0.05);
  margin-bottom: 1rem;
  width: 100%;
  max-width: 500px;
}

.primary-cta:hover {
  transform: translateY(-5px) scale(1.02);
  box-shadow: 
    0 20px 50px rgba(0, 0, 0, 0.4),
    0 0 0 4px rgba(255, 255, 255, 0.2),
    0 0 0 8px rgba(255, 255, 255, 0.1);
}

.primary-cta:active {
  transform: translateY(-2px) scale(1.01);
}

.cta-icon {
  font-size: 1.8rem;
}

.cta-arrow {
  font-size: 1.8rem;
  opacity: 0.8;
}

.cta-note {
  font-size: 1rem;
  opacity: 0.8;
}

/* 步骤预览 */
.steps-preview {
  margin-bottom: 3rem;
  padding: 2.5rem;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.steps-title {
  font-size: 2.2rem;
  font-weight: 700;
  margin-bottom: 2rem;
  color: white;
}

.steps-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2.5rem;
}

.step-card {
  background: rgba(255, 255, 255, 0.15);
  padding: 1.5rem;
  border-radius: 12px;
  text-align: left;
  transition: all 0.3s ease;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.step-card:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-3px);
}

.step-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 0.75rem;
}

.step-number {
  width: 40px;
  height: 40px;
  background: white;
  color: #667eea;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2rem;
  font-weight: 700;
  flex-shrink: 0;
}

.step-title {
  font-size: 1.3rem;
  font-weight: 600;
  color: white;
  margin: 0;
}

.step-description {
  font-size: 1rem;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

/* 次要CTA */
.secondary-cta {
  display: inline-block;
  padding: 1rem 2.5rem;
  font-size: 1.2rem;
  font-weight: 600;
  color: white;
  background: transparent;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.secondary-cta:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-2px);
}

/* 信任提示 */
.trust-note {
  margin-top: 2rem;
  padding-top: 2rem;
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}

.trust-note p {
  font-size: 1.1rem;
  opacity: 0.8;
}

.trust-note strong {
  color: white;
  opacity: 1;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .main-title {
    font-size: 2.5rem;
  }
  
  .main-subtitle {
    font-size: 1.2rem;
  }
  
  .value-text {
    font-size: 1.1rem;
  }
  
  .primary-cta {
    padding: 1.25rem 2rem;
    font-size: 1.3rem;
    gap: 0.75rem;
  }
  
  .cta-icon,
  .cta-arrow {
    font-size: 1.5rem;
  }
  
  .steps-preview {
    padding: 1.5rem;
  }
  
  .steps-title {
    font-size: 1.8rem;
  }
  
  .steps-grid {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .step-card {
    padding: 1.25rem;
  }
  
  .step-number {
    width: 35px;
    height: 35px;
    font-size: 1.1rem;
  }
  
  .step-title {
    font-size: 1.2rem;
  }
  
  .secondary-cta {
    padding: 0.875rem 2rem;
    font-size: 1.1rem;
  }
}

/* 深色模式优化 */
@media (prefers-color-scheme: dark) {
  .home {
    background: linear-gradient(135deg, #4c51bf 0%, #6b46c1 100%);
  }
  
  .step-card {
    background: rgba(255, 255, 255, 0.08);
  }
  
  .step-card:hover {
    background: rgba(255, 255, 255, 0.12);
  }
}
</style>
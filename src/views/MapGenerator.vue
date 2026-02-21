<template>
  <div class="map-generator">
    <!-- 主内容区域 -->
    <main class="main-content">
      <div class="content-wrapper">
        <!-- 标题区域 -->
        <div class="title-section">
          <h1 class="main-title">人生重置地图</h1>
          <p class="main-subtitle">基于你的访谈回答，生成个性化的人生重置行动计划</p>
        </div>
        
        <!-- 核心功能 -->
        <div class="core-features">
          <div class="feature-card">
            <div class="feature-icon">🗺️</div>
            <div class="feature-content">
              <h3>可视化行动计划</h3>
              <p>将复杂的行动计划转化为清晰的可视化地图，一目了然看到从现状到理想状态的完整路径。</p>
            </div>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">📥</div>
            <div class="feature-content">
              <h3>多种格式导出</h3>
              <p>支持PDF、PNG、Markdown等多种格式导出，方便保存、打印和分享。</p>
            </div>
          </div>
          
          <div class="feature-card">
            <div class="feature-icon">🎯</div>
            <div class="feature-content">
              <h3>个性化定制</h3>
              <p>根据你的偏好和需求，自定义地图样式、布局和重点内容。</p>
            </div>
          </div>
        </div>
        
        <!-- 主要CTA -->
        <div class="cta-section">
          <div class="cta-content">
            <h2 class="cta-title">开始生成你的个性化地图</h2>
            <p class="cta-description">基于你的人生重置访谈回答，创建专属的行动计划地图</p>
            
            <div class="cta-buttons">
              <button 
                class="primary-cta"
                @click="generateMap"
              >
                <span class="cta-icon">✨</span>
                <span>生成人生重置地图</span>
              </button>
              
              <button 
                class="secondary-cta"
                @click="viewInterview"
              >
                查看访谈回答
              </button>
            </div>
          </div>
        </div>
        
        <!-- 开发状态提示 -->
        <div class="development-notice">
          <div class="notice-content">
            <div class="notice-icon">🔄</div>
            <div>
              <h4>功能迁移中</h4>
              <p>地图生成器功能正在从原HTML版本迁移到Vue组件，原功能包含完整的可视化地图和导出功能。</p>
              <button 
                class="notice-button"
                @click="viewOriginal"
              >
                查看原版地图生成器
              </button>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const generateMap = () => {
  // 检查是否有访谈回答
  const answers = localStorage.getItem('life-reset-answers')
  if (!answers || JSON.parse(answers).every(answer => !answer.trim())) {
    alert('请先完成人生重置访谈，才能生成个性化地图。')
    router.push('/interview')
    return
  }
  
  // 暂时跳转到原版地图生成器
  viewOriginal()
}

const viewInterview = () => {
  router.push('/interview')
}

const viewOriginal = () => {
  window.open('/code-backup-20260221-1944/generate-map.html', '_blank')
}
</script>

<style scoped>
.map-generator {
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
}

/* 标题区域 */
.title-section {
  text-align: center;
  margin-bottom: 3rem;
}

.main-title {
  font-size: 3rem;
  font-weight: 800;
  margin-bottom: 1rem;
  line-height: 1.1;
  background: linear-gradient(135deg, #ffffff 0%, #e2e8f0 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.main-subtitle {
  font-size: 1.3rem;
  opacity: 0.9;
  line-height: 1.5;
}

/* 核心功能 */
.core-features {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  margin-bottom: 3rem;
}

.feature-card {
  display: flex;
  align-items: flex-start;
  gap: 1.5rem;
  padding: 1.5rem;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
}

.feature-card:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-3px);
}

.feature-icon {
  font-size: 2.5rem;
  flex-shrink: 0;
}

.feature-content h3 {
  font-size: 1.4rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: white;
}

.feature-content p {
  font-size: 1rem;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

/* 主要CTA */
.cta-section {
  margin-bottom: 3rem;
  padding: 2.5rem;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  text-align: center;
}

.cta-title {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 0.75rem;
  color: white;
}

.cta-description {
  font-size: 1.1rem;
  opacity: 0.9;
  margin-bottom: 2rem;
  line-height: 1.5;
}

.cta-buttons {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  align-items: center;
}

.primary-cta {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  padding: 1.25rem 2.5rem;
  font-size: 1.3rem;
  font-weight: 700;
  color: #667eea;
  background: white;
  border: none;
  border-radius: 14px;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
  min-width: 280px;
}

.primary-cta:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
}

.cta-icon {
  font-size: 1.5rem;
}

.secondary-cta {
  display: inline-block;
  padding: 0.875rem 2rem;
  font-size: 1.1rem;
  font-weight: 600;
  color: white;
  background: transparent;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s ease;
  min-width: 200px;
}

.secondary-cta:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.5);
}

/* 开发状态提示 */
.development-notice {
  padding: 1.5rem;
  background: rgba(255, 193, 7, 0.15);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  border: 1px solid rgba(255, 193, 7, 0.3);
}

.notice-content {
  display: flex;
  align-items: flex-start;
  gap: 1.25rem;
}

.notice-icon {
  font-size: 2rem;
  flex-shrink: 0;
}

.notice-content h4 {
  font-size: 1.2rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: #ffc107;
}

.notice-content p {
  font-size: 0.95rem;
  opacity: 0.9;
  line-height: 1.5;
  margin-bottom: 1rem;
}

.notice-button {
  padding: 0.5rem 1.25rem;
  font-size: 0.95rem;
  font-weight: 600;
  color: #ffc107;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 193, 7, 0.4);
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.notice-button:hover {
  background: rgba(255, 193, 7, 0.2);
  border-color: rgba(255, 193, 7, 0.6);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .main-title {
    font-size: 2.5rem;
  }
  
  .main-subtitle {
    font-size: 1.1rem;
  }
  
  .feature-card {
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 1rem;
  }
  
  .feature-icon {
    font-size: 2rem;
  }
  
  .feature-content h3 {
    font-size: 1.3rem;
  }
  
  .cta-title {
    font-size: 1.8rem;
  }
  
  .cta-description {
    font-size: 1rem;
  }
  
  .primary-cta {
    padding: 1rem 2rem;
    font-size: 1.2rem;
    min-width: 100%;
  }
  
  .secondary-cta {
    padding: 0.75rem 1.5rem;
    font-size: 1rem;
    min-width: 100%;
  }
  
  .notice-content {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }
}

/* 深色模式优化 */
@media (prefers-color-scheme: dark) {
  .map-generator {
    background: linear-gradient(135deg, #4c51bf 0%, #6b46c1 100%);
  }
  
  .feature-card {
    background: rgba(255, 255, 255, 0.08);
  }
  
  .feature-card:hover {
    background: rgba(255, 255, 255, 0.12);
  }
  
  .cta-section {
    background: rgba(255, 255, 255, 0.08);
  }
  
  .development-notice {
    background: rgba(255, 193, 7, 0.1);
  }
}
</style>
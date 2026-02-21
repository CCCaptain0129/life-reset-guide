<template>
  <div class="resources">
    <!-- 主内容区域 -->
    <main class="main-content">
      <div class="content-wrapper">
        <!-- 标题区域 -->
        <div class="title-section">
          <h1 class="main-title">人生重置资源库</h1>
          <p class="main-subtitle">精选的学习资源、工具和社区，帮助你更好地进行人生重置</p>
        </div>
        
        <!-- 资源分类 -->
        <div class="resource-categories">
          <h2 class="section-title">资源分类</h2>
          <div class="categories-grid">
            <div 
              class="category-card" 
              v-for="category in categories" 
              :key="category.id"
            >
              <div class="category-header">
                <span class="category-icon">{{ category.icon }}</span>
                <h3 class="category-title">{{ category.title }}</h3>
              </div>
              <p class="category-description">{{ category.description }}</p>
              <div class="category-footer">
                <span class="resource-count">{{ category.count }}个资源</span>
              </div>
            </div>
          </div>
        </div>
        
        <!-- 核心CTA -->
        <div class="cta-section">
          <div class="cta-content">
            <h2 class="cta-title">探索完整资源库</h2>
            <p class="cta-description">访问原版资源页面，查看完整的资源列表和详细推荐</p>
            
            <button 
              class="primary-cta"
              @click="viewOriginal"
            >
              <span class="cta-icon">📚</span>
              <span>查看完整资源列表</span>
            </button>
          </div>
        </div>
        
        <!-- 开发状态提示 -->
        <div class="development-notice">
          <div class="notice-content">
            <div class="notice-icon">🔄</div>
            <div>
              <h4>资源库升级中</h4>
              <p>资源推荐功能正在升级，未来将加入个性化推荐算法和智能搜索功能。</p>
              <p>原资源列表已备份，包含详细的书籍、课程、工具推荐。</p>
            </div>
          </div>
        </div>
        
        <!-- 未来功能预览 -->
        <div class="future-features">
          <h2 class="section-title">计划中的智能功能</h2>
          <div class="features-grid">
            <div class="feature-card">
              <div class="feature-icon">🤖</div>
              <div class="feature-content">
                <h4>个性化推荐</h4>
                <p>根据你的访谈回答和兴趣，智能推荐最相关的资源</p>
              </div>
            </div>
            
            <div class="feature-card">
              <div class="feature-icon">🔍</div>
              <div class="feature-content">
                <h4>智能搜索</h4>
                <p>支持关键词搜索、标签过滤、评分排序</p>
              </div>
            </div>
            
            <div class="feature-card">
              <div class="feature-icon">💾</div>
              <div class="feature-content">
                <h4>收藏管理</h4>
                <p>收藏感兴趣的资源，创建个人学习清单</p>
              </div>
            </div>
            
            <div class="feature-card">
              <div class="feature-icon">📊</div>
              <div class="feature-content">
                <h4>学习进度</h4>
                <p>跟踪资源学习进度，记录笔记和心得</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const categories = ref([
  {
    id: 1,
    icon: '📖',
    title: '书籍推荐',
    description: '经典和现代的人生规划、心理学、自我发展书籍',
    count: 25
  },
  {
    id: 2,
    icon: '🎓',
    title: '在线课程',
    description: 'MOOC平台上的优质课程，涵盖多个领域',
    count: 18
  },
  {
    id: 3,
    icon: '🛠️',
    title: '工具应用',
    description: '提高效率、习惯养成、目标跟踪的实用工具',
    count: 32
  },
  {
    id: 4,
    icon: '👥',
    title: '社区论坛',
    description: '相关的在线社区、讨论组和支持团体',
    count: 15
  },
  {
    id: 5,
    icon: '🎧',
    title: '播客视频',
    description: '有价值的播客节目和YouTube频道',
    count: 22
  },
  {
    id: 6,
    icon: '📝',
    title: '模板工具',
    description: '可直接使用的计划模板、工作表',
    count: 12
  }
])

const viewOriginal = () => {
  window.open('/code-backup-20260221-1944/resources.html', '_blank')
}
</script>

<style scoped>
.resources {
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
  max-width: 1000px;
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
  max-width: 600px;
  margin: 0 auto;
}

/* 资源分类 */
.resource-categories {
  margin-bottom: 3rem;
}

.section-title {
  font-size: 2.2rem;
  font-weight: 700;
  margin-bottom: 2rem;
  text-align: center;
  color: white;
}

.categories-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
}

.category-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  padding: 1.5rem;
  transition: all 0.3s ease;
}

.category-card:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-3px);
}

.category-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
}

.category-icon {
  font-size: 2rem;
}

.category-title {
  font-size: 1.3rem;
  font-weight: 600;
  color: white;
  margin: 0;
}

.category-description {
  font-size: 0.95rem;
  opacity: 0.9;
  line-height: 1.5;
  margin-bottom: 1.5rem;
  min-height: 4.5em;
}

.category-footer {
  padding-top: 1rem;
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}

.resource-count {
  display: inline-block;
  padding: 0.3rem 0.75rem;
  background: rgba(255, 255, 255, 0.15);
  border-radius: 12px;
  font-size: 0.9rem;
  font-weight: 500;
}

/* 核心CTA */
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
}

.primary-cta:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
}

.cta-icon {
  font-size: 1.5rem;
}

/* 开发状态提示 */
.development-notice {
  margin-bottom: 3rem;
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
  margin-bottom: 0.5rem;
}

/* 未来功能预览 */
.future-features {
  margin-bottom: 2rem;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 1.5rem;
}

.feature-card {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.25rem;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
}

.feature-card:hover {
  background: rgba(255, 255, 255, 0.15);
}

.feature-icon {
  font-size: 1.8rem;
  flex-shrink: 0;
}

.feature-content h4 {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: white;
}

.feature-content p {
  font-size: 0.9rem;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .main-title {
    font-size: 2.5rem;
  }
  
  .main-subtitle {
    font-size: 1.1rem;
  }
  
  .section-title {
    font-size: 1.8rem;
  }
  
  .categories-grid {
    grid-template-columns: 1fr;
  }
  
  .category-description {
    min-height: auto;
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
    width: 100%;
  }
  
  .notice-content {
    flex-direction: column;
    align-items: center;
    text-align: center;
  }
  
  .features-grid {
    grid-template-columns: 1fr;
  }
}

/* 深色模式优化 */
@media (prefers-color-scheme: dark) {
  .resources {
    background: linear-gradient(135deg, #4c51bf 0%, #6b46c1 100%);
  }
  
  .category-card {
    background: rgba(255, 255, 255, 0.08);
  }
  
  .category-card:hover {
    background: rgba(255, 255, 255, 0.12);
  }
  
  .cta-section {
    background: rgba(255, 255, 255, 0.08);
  }
  
  .development-notice {
    background: rgba(255, 193, 7, 0.1);
  }
  
  .feature-card {
    background: rgba(255, 255, 255, 0.08);
  }
  
  .feature-card:hover {
    background: rgba(255, 255, 255, 0.12);
  }
}
</style>
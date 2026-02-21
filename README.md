# 人生重置向导 - 代码目录

## 项目概述
这是一个交互式的人生重置向导单页应用，帮助用户通过五阶段访谈系统化地重新设计自己的生活。

## 技术栈
- **前端**: HTML + CSS + JavaScript (Vanilla)
- **构建工具**: Vite (配置在 package.json 中)
- **依赖**: Vue.js 3 + 相关工具（用于未来升级）

## 功能页面
1. **index.html** - 主页面，项目介绍和导航
2. **interactive.html** - 交互式五阶段访谈
3. **generate-map.html** - 人生重置地图生成器
4. **resources.html** - 相关资源推荐
5. **ssl-status.html** - SSL/TLS 状态检查工具

## 项目结构
```
code/
├── index.html          # 主页面
├── interactive.html    # 交互式访谈
├── generate-map.html   # 地图生成器
├── resources.html      # 资源页面
├── ssl-status.html     # SSL状态检查
├── package.json        # 项目配置
├── public/             # 静态资源
├── src/                # 源代码（未来Vue.js升级）
│   ├── assets/         # 图片、样式等
│   ├── components/     # 可复用组件
│   ├── router/         # 路由配置
│   ├── store/          # 状态管理
│   ├── utils/          # 工具函数
│   └── views/          # 页面组件
└── templates/          # 模板文件
    ├── 人生重置地图模板.md
    ├── 周计划模板.md
    └── 每日复盘模板.md
```

## 快速开始

### 开发环境
```bash
# 进入代码目录
cd code

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

### 生产部署
```bash
# 构建项目
npm run build

# 部署构建后的文件到Web服务器
```

## 设计原则
1. **渐进增强**：当前使用原生技术，可平滑升级到Vue.js
2. **响应式设计**：支持各种设备尺寸
3. **性能优化**：快速加载，流畅交互
4. **可访问性**：考虑无障碍访问需求

## 许可证
MIT License
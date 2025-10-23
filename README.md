# Earth WASM Parser

Earth WebAssembly 模块的完整分析工具集，用于解析 Google Earth 的 WASM 模块和 Protobuf 消息定义。

## 📋 项目简介

本项目深入分析了 Google Earth Web 应用的 WASM 模块，包括：

- **3,789 个 Protobuf 消息类型** 的完整定义
- **48 个 WASM 导出函数** 的映射关系（已破解混淆）
- **487+1,202 个 Proto 源文件** 的提取和分析
- **前端开发接口文档** 和使用指南

## 🎯 主要功能

### 1. WASM 模块分析
- 函数导出和导入分析
- 混淆函数名破解
- 内存和表结构分析

### 2. Protobuf 消息分析
- 完整消息类型提取
- 命名空间分类
- 字段结构解析

### 3. 前端 API 文档
- 接口作用和参数说明
- 使用示例和最佳实践
- 编码辅助函数

## 📊 分析成果

### 统计信息

| 项目 | 数量 |
|------|------|
| Proto 消息类型 | 3,789 |
| Proto 源文件 | 1,689 |
| 命名空间 | 455 |
| WASM 函数 | 48 |
| 分析文档 | 15+ |

### 主要命名空间

- `earth.*` - Earth 核心功能
- `geo.*` - 地理数据
- `maps.*` - 地图服务
- `geostore.*` - 地理数据存储
- `google.protobuf.*` - Protobuf 标准

## 📚 文档结构

### 核心分析文档

- **[ANALYSIS_SUMMARY.md](./ANALYSIS_SUMMARY.md)** - 分析总结
- **[EARTHPLUGIN_COMPLETE_ANALYSIS.md](./EARTHPLUGIN_COMPLETE_ANALYSIS.md)** - WASM 文件完整分析
- **[EARTHPLUGIN_WEB_DIRECTORY_ANALYSIS.md](./EARTHPLUGIN_WEB_DIRECTORY_ANALYSIS.md)** - Proto 目录分析
- **[EARTHSTUDIOWASM_ANALYSIS.md](./EARTHSTUDIOWASM_ANALYSIS.md)** - Earth Studio 分析

### API 文档

- **[FRONTEND_API_DEEP_ANALYSIS.md](./FRONTEND_API_DEEP_ANALYSIS.md)** - API 深度分析 ⭐
- **[FRONTEND_API_COMPLETE.md](./FRONTEND_API_COMPLETE.md)** - 完整接口列表
- **[FRONTEND_API_QUICK_REFERENCE.md](./FRONTEND_API_QUICK_REFERENCE.md)** - 快速参考
- **[frontend_api_helper.js](./frontend_api_helper.js)** - API 辅助库

### 技术文档

- **[WASM_OBFUSCATED_FUNCTIONS.md](./WASM_OBFUSCATED_FUNCTIONS.md)** - 混淆函数映射
- **[WASM_FUNCTIONS_ANALYSIS.md](./WASM_FUNCTIONS_ANALYSIS.md)** - 函数分析
- **[WASM_FULL_ANALYSIS.md](./WASM_FULL_ANALYSIS.md)** - 完整分析
- **[PROTO_USAGE_GUIDE.md](./PROTO_USAGE_GUIDE.md)** - Protobuf 使用指南
- **[COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md)** - 完整消息列表

### 分类文档

- **[docs/proto/INDEX.md](./docs/proto/INDEX.md)** - 分类索引
- 按功能分类的详细文档

## 🚀 快速开始

### 1. 查看前端接口文档

```bash
# 查看完整接口文档
cat FRONTEND_API_DEEP_ANALYSIS.md

# 查看快速参考
cat FRONTEND_API_QUICK_REFERENCE.md
```

### 2. 使用 API 辅助库

```javascript
// 引入辅助库
import { EarthWasmAPI } from './frontend_api_helper.js';

// 创建 API 实例
const api = new EarthWasmAPI(window.Module);

// 发送鼠标事件
api.sendMouseDown(100, 200);
api.sendMouseMove(150, 250);
api.sendMouseUp(150, 250);

// 搜索地点
api.search("北京天安门");

// 飞向位置
api.flyTo({
  latitude: 39.9042,
  longitude: 116.4074,
  range: 1000,
  tilt: 45
});
```

### 3. 查看 Protobuf 定义

```bash
# 查看 Earth 核心定义
cat earthplugin_web/geo/earth/proto/commands.proto

# 查看相机定义
cat earthplugin_web/maps/shared/common/geom/geom.proto
```

## 🛠️ 主要接口

### 输入控制
- `earth.InputEvent` - 鼠标、键盘、触摸事件

### 搜索
- `geo.earth.proto.PerformSearch` - 执行搜索
- `geo.earth.proto.OpenKnowledgeCard` - 打开知识卡片

### 相机控制
- `geo.earth.proto.FlyToCamera` - 飞向相机位置
- `ResizeViewport` - 调整视口大小

### 文档管理
- `geo.earth.proto.OpenKmlDocument` - 打开 KML 文档
- `geo.earth.proto.CreatePointPlacemark` - 创建点标记

### 图层控制
- `geo.earth.proto.ToggleLayer` - 切换图层

详情见 [FRONTEND_API_DEEP_ANALYSIS.md](./FRONTEND_API_DEEP_ANALYSIS.md)

## 📖 使用说明

详见 [使用说明.md](./使用说明.md)

## 🔍 分析工具

本项目使用了以下工具和方法：

- **pbtk** - Protobuf 逆向工程工具
- **Node.js** - 脚本分析
- **WebAssembly API** - WASM 模块分析
- **grep/strings** - 字符串提取

## 📦 项目结构

```
.
├── wasm/                      # WASM 源文件
│   ├── earthplugin_web.wasm  # WASM 模块 (20MB)
│   ├── earthplugin_web.js    # Emscripten 胶水代码
│   └── plugins_compiled.js   # 插件和初始化代码
├── earthplugin_web/          # EarthPlugin Web Proto 文件 (487 个)
├── earthstudiowasm/          # Earth Studio Proto 文件 (1,202 个)
├── docs/                     # 分析文档
├── lib/                      # Dart 源代码
├── bin/                      # 服务器代码
└── [各种分析文档]             # Markdown 文档
```

## 🎯 适用场景

- **前端开发** - 集成 Earth WASM 到网页应用
- **逆向工程** - 分析 Google Earth 的实现
- **学习研究** - 了解 WASM 和 Protobuf 的使用
- **二次开发** - 基于 Earth 引擎开发自定义应用

## 📝 相关资源

- [pbtk 工具](https://github.com/marin-m/pbtk) - Protobuf 逆向工程
- [Protobuf 官方文档](https://developers.google.com/protocol-buffers)
- [Emscripten 文档](https://emscripten.org/docs/introducing_emscripten/about_emscripten.html)

## 📄 许可证

本项目仅供学习和研究使用。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📧 联系方式

如有问题或建议，请提交 Issue。


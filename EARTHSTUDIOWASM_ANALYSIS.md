# EarthStudio WASM 目录完整分析

## 📊 概览

`earthstudiowasm/` 目录是 Earth Studio 应用的完整 Protobuf 定义。

### 统计信息

- **总 Proto 文件数**: 1,202 个
- **总目录数**: 367 个
- **总大小**: 2,394.25 KB (~2.34 MB)
- **平均文件大小**: 2,040 bytes

## 📁 顶级目录统计

| 目录 | 文件数 | 说明 |
|------|--------|------|
| `geo` | 373 | 地理相关（最多） |
| `maps` | 320 | 地图服务 |
| `logs` | 174 | 日志相关 |
| `geostore` | 153 | 地理数据存储 |
| `google` | 51 | Google 标准库 |
| `gws` | 15 | Google Web Server |
| `java` | 13 | Java 相关 |
| `knowledge` | 11 | 知识图谱 |
| `storage` | 9 | 存储 |
| `monitoring` | 8 | 监控 |
| `privacy` | 8 | 隐私 |
| `search` | 8 | 搜索 |
| `net` | 7 | 网络 |
| `travel` | 7 | 旅行 |
| `photos` | 4 | 照片 |
| 其他 | 140 | 其他模块 |

## 📄 最大的文件

### Top 15 文件

| 文件名 | 大小 | 说明 |
|--------|------|------|
| `legend-named-style.proto` | 95,972 bytes | 图例命名样式 |
| `logs_types.proto` | 74,522 bytes | 日志类型定义 |
| `navigation_session_events.proto` | 64,660 bytes | 导航会话事件 |
| `earth_log.proto` | 41,459 bytes | Earth 日志 |
| `datasourceprovider.proto` | 35,840 bytes | 数据源提供者 |
| `searchbox_stats.proto` | 35,736 bytes | 搜索框统计 |
| `refinements.proto` | 31,036 bytes | 精炼/优化 |
| `intent.proto` | 30,491 bytes | 意图识别 |
| `directions-common.proto` | 28,829 bytes | 方向通用 |
| `feature.proto` | 24,860 bytes | 地理要素 |
| `featureupdate.proto` | 23,250 bytes | 要素更新 |
| `client-vector-style.proto` | 21,752 bytes | 客户端矢量样式 |
| `experiments.proto` | 20,114 bytes | 实验配置 |
| `state.proto` | 19,518 bytes | 状态管理 |
| `descriptor.proto` | 18,968 bytes | 描述符 |

## 🔍 Earth Studio 特有内容

### geo/earth/app/cpp/core/ 目录

Earth Studio 特有的核心定义：

```
geo/earth/app/cpp/core/
├── arguments.proto                      # 参数定义
├── design/
│   ├── designexport.proto              # 设计导出
│   └── ...
├── designinput/
│   ├── designvalidation.proto         # 设计验证
│   └── validinputs.proto               # 有效输入
├── deeplink/
│   └── legacydatastate.proto           # 深度链接数据状态
├── account/
│   └── authinfo.proto                  # 认证信息
└── state/                              # 状态管理
    ├── addbuildingtypes.proto
    ├── apptheme.proto
    ├── backnavigation.proto
    ├── bottomsheet.proto
    ├── boundaryselection.proto
    ├── buildingeditor.proto
    └── ... (50+ 个状态文件)
```

### 新增功能模块

对比 `earthplugin_web`，Earth Studio 增加了：

1. **设计相关** - design, designinput, designexport
2. **状态管理** - 50+ 个状态文件
3. **内容流** - contentflows
4. **广告/旅行** - ads/travel
5. **监控** - monitoring
6. **照片** - photos
7. **视频** - video

## 📊 与 EarthPlugin Web 对比

### 文件对比

| 指标 | earthplugin_web | earthstudiowasm | 差异 |
|------|----------------|-----------------|------|
| 文件数 | 487 | 1,202 | +715 (+146.8%) |
| 目录数 | 139 | 367 | +228 (+164%) |
| 文件大小 | 1.16 MB | 2.39 MB | +1.23 MB (+106.5%) |
| 共同文件 | - | 448 | - |
| 独有文件 | 22 | 640 | - |

### 关键差异

**EarthStudio 新增的主要模块**:

1. **设计功能** (design*)
   - 设计创建、验证、导出
   - 设计输入管理

2. **状态管理** (state/*)
   - 50+ 个状态文件
   - UI 状态、导航状态、编辑器状态

3. **内容创建** (contentflows)
   - 内容流程管理
   - API 集成

4. **日志和分析** (logs, monitoring)
   - 详细的日志类型
   - 监控和统计

5. **广告和商务** (ads, travel)
   - 酒店、旅行相关
   - 价格、优惠

## 🎯 关键文件分析

### arguments.proto

Earth Studio 的参数定义，包含应用启动和配置参数。

### designvalidation.proto

设计验证逻辑，确保设计数据有效。

### legacydatastate.proto

历史数据状态管理，支持深度链接和状态恢复。

### 状态文件示例

```
state/addbuildingtypes.proto      # 添加建筑类型
state/apptheme.proto              # 应用主题
state/backnavigation.proto        # 返回导航
state/bottomsheet.proto           # 底部面板
state/boundaryselection.proto     # 边界选择
state/buildingeditor.proto        # 建筑编辑器
...
```

## 📚 目录结构

```
earthstudiowasm/
├── geo/                    # 373 个文件
│   ├── earth/            # Earth 应用核心
│   ├── contentflows/      # 内容流（Studio 特有）
│   ├── imagery/           # 图像处理
│   └── ...
├── maps/                   # 320 个文件
├── logs/                   # 174 个文件
├── geostore/              # 153 个文件
├── google/                # 51 个文件
└── ...                     # 其他模块
```

## 🔗 相关文档

- [EARTHPLUGIN_WEB_DIRECTORY_ANALYSIS.md](./EARTHPLUGIN_WEB_DIRECTORY_ANALYSIS.md) - EarthPlugin Web 分析
- [EARTHPLUGIN_COMPLETE_ANALYSIS.md](./EARTHPLUGIN_COMPLETE_ANALYSIS.md) - 完整 WASM 分析
- [ANALYSIS_SUMMARY.md](./ANALYSIS_SUMMARY.md) - 全局总结

## 📝 总结

### EarthStudio WASM vs EarthPlugin Web

| 特性 | EarthStudio | EarthPlugin Web |
|------|------------|----------------|
| **定位** | 设计编辑工具 | 地球可视化器 |
| **文件数** | 1,202 | 487 |
| **功能** | 设计创建、编辑、导出 | 地球浏览、交互 |
| **状态管理** | 50+ 状态文件 | 基础状态 |
| **设计相关** | ✅ 完整支持 | ❌ 无 |
| **内容流** | ✅ 支持 | ❌ 无 |

### 关键发现

1. **EarthStudio 更加复杂**
   - 文件数是 EarthPlugin Web 的 2.5 倍
   - 包含完整的设计编辑功能

2. **特有功能**
   - 设计创建和验证
   - 复杂的状态管理
   - 内容流处理
   - 广告和商务集成

3. **共同基础**
   - 共享 448 个文件
   - 都基于相同的 geo, maps, geostore 基础

EarthStudio 是 EarthPlugin Web 的高级版本，专门用于创建和编辑地理内容。


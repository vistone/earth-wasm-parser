# EarthPlugin Web 目录完整分析

## 📊 目录概览

`earthplugin_web/` 目录包含从 WASM 文件中提取出的完整 Protobuf 定义文件。

### 统计信息

- **总 Proto 文件数**: 487 个
- **总目录数**: 139 个
- **总大小**: 1,159.64 KB (~1.13 MB)
- **平均文件大小**: 2,438 bytes

## 📁 主要命名空间统计

### Top 10 命名空间

| 命名空间 | 文件数 | 说明 |
|---------|--------|------|
| `geostore.base.proto` | 145 | 地理数据存储基础定义 |
| `google.internal.earth.v1.builtenv` | 20 | Google Earth 建筑环境 |
| `maps.paint.proto` | 19 | 地图绘制 |
| `maps.tactile.api.shared` | 17 | 地图触觉 API 共享 |
| `maps.tactile.api` | 13 | 地图触觉 API |
| `maps.tactile.api.shared.directions` | 12 | 方向导航 |
| `google.api` | 10 | Google API 标准 |
| `logs.proto.geo.earth.app` | 9 | Earth 应用日志 |
| `geo.earth.app.cpp.core.protos` | 8 | Earth C++ 核心协议 |
| `geo.serving.proto.directions.request` | 8 | 方向请求 |

## 📂 目录结构

### 主要模块

```
earthplugin_web/
├── geo/                    # 地理相关
│   ├── earth/             # Earth 应用
│   ├── serving/           # 地理服务
│   └── case/              # 案例
├── geostore/              # 地理数据存储
│   ├── base/proto/        # 基础定义 (145 个文件)
│   └── ontology/          # 本体
├── maps/                   # 地图服务
│   ├── paint/             # 地图绘制
│   ├── tactile/           # 触觉反馈
│   └── spotlight/         # 聚光灯
├── google/                 # Google 标准库
│   ├── api/               # API 定义
│   ├── protobuf/          # Protobuf 标准
│   └── internal/earth/   # Earth 内部定义
├── logs/                   # 日志相关
├── storage/                # 存储相关
├── privacy/                # 隐私相关
└── ...                     # 其他模块
```

## 📄 最大的文件

### Top 10 文件

| 文件名 | 大小 | 说明 |
|--------|------|------|
| `legend-named-style.proto` | 96,829 bytes | 图例命名样式 |
| `earth_log.proto` | 53,370 bytes | Earth 日志定义 |
| `datasourceprovider.proto` | 36,364 bytes | 数据源提供者 |
| `searchbox_stats.proto` | 36,172 bytes | 搜索框统计 |
| `directions-common.proto` | 29,177 bytes | 方向通用定义 |
| `sign.proto` | 25,958 bytes | 标识定义 |
| `feature.proto` | 25,104 bytes | 地理要素 |
| `featureupdate.proto` | 23,454 bytes | 要素更新 |
| `experiments.proto` | 20,815 bytes | 实验配置 |
| `content_editing_model.proto` | 20,720 bytes | 内容编辑模型 |

## 🔍 关键 Proto 文件

### Earth 核心定义

```
geo/earth/proto/
├── commands.proto                    # 命令定义
├── contentcreation/                 # 内容创建
│   ├── feature_model.proto
│   ├── content_editing_model.proto
│   └── ...
├── documentnamespace.proto          # 文档命名空间
├── map_type.proto                   # 地图类型
├── mapstyle.proto                   # 地图样式
└── storage_restrictions.proto       # 存储限制
```

### Geostore 基础定义 (145 个文件)

```
geostore/base/proto/
├── feature.proto                     # 地理要素
├── attribute.proto                   # 属性
├── geometry.proto                    # 几何体
├── metadata.proto                    # 元数据
├── datasource.proto                  # 数据源
└── ... (共 145 个文件)
```

### Maps 相关

```
maps/
├── paint/proto/                      # 地图绘制
│   ├── paint-request.proto
│   ├── pipe-metadata.proto
│   └── ...
├── tactile/api/                      # 触觉 API
│   ├── shared/
│   ├── directions/
│   └── ...
└── spotlight/proto/                 # 聚光灯
```

## 🎯 与之前分析的关系

### 对比统计

| 指标 | earthplugin_web/ | 之前分析 |
|------|------------------|----------|
| Proto 文件数 | 487 个 | ~200 个路径引用 |
| Protobuf 消息类型 | 487 个定义文件 | 3,789 个消息类型 |
| 命名空间 | 139 个目录 | 455 个命名空间 |

**说明**: 
- `earthplugin_web/` 目录包含实际的 `.proto` 源文件
- 之前分析的 3,789 个消息类型是编译后的二进制形式
- 这些文件是原始源码，更容易阅读和理解

## 📚 使用建议

### 1. 查找特定的 Proto 定义

```bash
# 查找包含 "InputEvent" 的文件
find earthplugin_web -name "*.proto" -exec grep -l "InputEvent" {} \;

# 查找 Camera 相关定义
find earthplugin_web -name "*.proto" -exec grep -l "Camera" {} \;
```

### 2. 按命名空间浏览

```bash
# 查看 geostore 的定义
ls earthplugin_web/geostore/base/proto/

# 查看 Earth 核心定义
ls earthplugin_web/geo/earth/proto/
```

### 3. 理解消息结构

这些 `.proto` 文件提供了完整的消息定义，包括：
- 字段类型和编号
- 消息层次结构
- 注释和说明
- 枚举值定义

## 🔗 相关文档

- [EARTHPLUGIN_COMPLETE_ANALYSIS.md](./EARTHPLUGIN_COMPLETE_ANALYSIS.md) - WASM 文件分析
- [COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md) - 消息类型列表
- [WASM_OBFUSCATED_FUNCTIONS.md](./WASM_OBFUSCATED_FUNCTIONS.md) - 函数映射
- [PBTK_EXTRACTION_SUMMARY.md](./PBTK_EXTRACTION_SUMMARY.md) - pbtk 提取总结

## 📝 总结

`earthplugin_web/` 目录是 Earth WASM 应用的完整 Protobuf 定义源码，包含：

1. **487 个 Proto 文件** - 完整的消息定义
2. **139 个目录** - 组织结构清晰
3. **主要模块** - geo, geostore, maps, google 等
4. **易于阅读** - 纯文本格式，带有注释

这些文件是理解和使用 Earth WASM 模块的重要参考。


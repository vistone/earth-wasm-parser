# Earth WASM Protobuf 消息完整文档索引

## 📊 统计信息

- **总消息数**: 3,789 个
- **命名空间数**: 455 个
- **分类数**: 9 个

## 📚 文档结构

### 1. 核心模块 (earth.*)
- [earth Core](./earth_core.md) - Earth 核心消息（如 InputEvent, Camera）
- [earth State](./earth_state.md) - 状态管理 (237 个消息)
- [earth Feature](./earth_feature.md) - 功能管理 (135 个消息)
- [earth Config](./earth_config.md) - 配置管理 (57 个消息)

### 2. Google 标准 (google.*)
- [Google Standard](./google_standard.md) - Protobuf 和 API 标准 (69 个消息)
- [Google Internal](./google_internal.md) - Google 内部消息 (222 个消息)

### 3. 地图服务 (maps.*)
- [Maps](./maps.md) - 地图绘制和服务 (277 个消息)

### 4. 地理数据 (geo.*)
- [Geo](./geo.md) - 地理数据存储和服务 (440 个消息)

### 5. 质量控制 (quality.*)
- [Quality](./quality.md) - 查询质量控制 (137 个消息)

### 6. 其他模块
- [Other](./other.md) - 其他功能模块 (2,215 个消息)

## 🔥 关键消息类型

### earth.InputEvent
鼠标和键盘事件控制，用于地球的旋转、缩放、平移。

**字段**:
- `pointer_down` (bool) - 指针按下状态
- `button` (uint32) - 按钮编号 (0=无, 1=左键, 4=释放)
- `type` (uint32) - 事件类型 (1=mousedown, 2=mouseup, 3=mousemove, 4=wheel)
- `x`, `y` (double) - 坐标
- `delta_x`, `delta_y` (double) - 滚轮增量

### earth.Camera
相机配置和状态。

### earth.Location
地理位置信息。

### google.protobuf.Any
任意消息类型容器。

## 📖 使用说明

1. 查看完整列表: [COMPLETE_PROTO_LIST.md](../../COMPLETE_PROTO_LIST.md)
2. API 使用指南: [WASM_API.md](../../WASM_API.md)
3. 详细分析: [WASM_FULL_ANALYSIS.md](../../WASM_FULL_ANALYSIS.md)

## 🎯 快速查找

- 输入事件: [earth Core](./earth_core.md) → InputEvent
- 相机控制: [earth Core](./earth_core.md) → Camera
- 状态管理: [earth State](./earth_state.md)
- 地图绘制: [Maps](./maps.md)
- 地理数据: [Geo](./geo.md)

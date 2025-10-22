# Earth WASM Protobuf 消息使用指南

## 📚 文档结构

本项目提供了完整的 Protobuf 消息分析和文档：

### 主要文档

1. **[WASM_PROTO_MESSAGES.md](./WASM_PROTO_MESSAGES.md)** - 消息类型概览
2. **[COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md)** - 完整的 3,789 个消息列表
3. **[PROTO_FULL_DOCUMENTATION.md](./PROTO_FULL_DOCUMENTATION.md)** - 按分类的完整文档
4. **[docs/proto/](./docs/proto/)** - 按模块分类的详细文档

### 详细分类文档

- [earth Core](./docs/proto/earth_core.md) - Earth 核心消息 (13 个)
- [earth State](./docs/proto/earth_state.md) - 状态管理 (237 个)
- [earth Feature](./docs/proto/earth_feature.md) - 功能管理 (135 个)
- [earth Config](./docs/proto/earth_config.md) - 配置管理 (57 个)
- [Google Standard](./docs/proto/google_standard.md) - Protobuf 标准 (69 个)
- [Google Internal](./docs/proto/google_internal.md) - Google 内部 (222 个)
- [Maps](./docs/proto/maps.md) - 地图服务 (277 个)
- [Geo](./docs/proto/geo.md) - 地理数据 (440 个)
- [Quality](./docs/proto/quality.md) - 质量控制 (137 个)
- [Other](./docs/proto/other.md) - 其他模块 (2,215 个)

## 🔥 关键消息类型

### earth.InputEvent

**用途**: 鼠标和键盘输入事件控制

**字段定义**:
```protobuf
message InputEvent {
  bool pointer_down = 1;      // 指针按下状态
  uint32 button = 2;           // 按钮编号 (0=无, 1=左键, 4=释放)
  uint32 type = 3;             // 事件类型
  uint32 event_id = 4;         // 事件 ID
  double x = 5;                // X 坐标
  double y = 6;                // Y 坐标
  double delta_x = 7;          // 滚轮 delta X
  double delta_y = 8;          // 滚轮 delta Y
  bool pointer_up = 10;        // 指针释放状态
}
```

**事件类型**:
- `1` - mousedown
- `2` - mouseup
- `3` - mousemove
- `4` - wheel

**使用示例**:
```javascript
// 发送鼠标按下事件
const encodeMouseDown = (x, y) => {
  const buf = new ArrayBuffer(28);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag
  arr[1] = 26;  // length
  arr[2] = 8;   // field 1 (pointer_down)
  arr[3] = 1;   // value: true
  arr[4] = 16;  // field 2 (button)
  arr[5] = 1;   // value: 1 (left button)
  arr[6] = 24;  // field 3 (type)
  arr[7] = 1;   // value: 1 (mousedown)
  arr[8] = 32;  // field 4 (event_id)
  arr[9] = 0;   // value: 0
  arr[10] = 41; // field 5 (x, wire type 1=double)
  view.setFloat64(11, x, true);
  arr[19] = 49; // field 6 (y, wire type 1=double)
  view.setFloat64(20, y, true);
  
  return arr;
};

// 调用 WASM 函数
window.Module.ReceiveViewModelCommand('earth.InputEvent', encodeMouseDown(100, 200));
```

### earth.Camera

相机配置和状态管理。

### earth.Location

地理位置信息。

### google.protobuf.Any

任意消息类型容器，用于动态消息传递。

## 📊 统计信息

- **总消息数**: 3,789 个
- **命名空间数**: 455 个
- **主要分类**: 9 个

### 主要命名空间（按消息数量）

1. `earth.document.protos` - 407 个消息
2. `geostore` - 276 个消息
3. `earth.state` - 133 个消息
4. `earth.state.derivedstate` - 104 个消息
5. `google.internal.earth.v1.builtenv` - 102 个消息
6. `maps_paint` - 102 个消息
7. `earth.featureupdater` - 96 个消息
8. `geo.earth.proto` - 70 个消息
9. `quality_qrewrite` - 64 个消息
10. `google.internal.earth.v1` - 57 个消息

## 🛠️ 使用场景

### 1. 鼠标事件控制

地球的旋转、缩放、平移操作通过 `earth.InputEvent` 实现。

**实现方式**: 手动编码 Protobuf Wire Format 并调用 `ReceiveViewModelCommand`

### 2. 相机控制

通过 `earth.Camera` 配置视角、位置、缩放级别。

### 3. 状态管理

通过 `earth.state.*` 命名空间的消息管理应用状态。

### 4. 地图绘制

通过 `maps_paint.*` 和相关命名空间处理地图渲染。

### 5. 地理数据

通过 `geostore.*` 和 `geo.*` 命名空间处理地理数据。

## 📖 相关文档

- [WASM_API.md](./WASM_API.md) - WASM 模块 API 使用指南
- [WASM_FULL_ANALYSIS.md](./WASM_FULL_ANALYSIS.md) - 完整的 WASM 分析
- [ARCHITECTURE.md](./ARCHITECTURE.md) - 项目架构说明

## 🔍 查找消息

### 按命名空间查找

1. 确定消息所属命名空间
2. 查看对应的分类文档（如 earth Core → earth_core.md）
3. 查找具体的消息名称

### 按功能查找

- 输入控制 → earth_core.md
- 状态管理 → earth_state.md
- 地图绘制 → maps.md
- 地理数据 → geo.md
- 配置管理 → earth_config.md

## 💡 最佳实践

1. **使用 Protobuf Wire Format**: 手动编码消息以减少依赖
2. **事件类型**: 遵循标准的事件类型编号
3. **坐标系统**: 使用双精度浮点数表示坐标
4. **错误处理**: 确保消息格式正确后再调用 WASM 函数
5. **性能优化**: 批量发送事件以提高性能

## 📝 注意事项

- Protobuf 消息必须使用正确的 Wire Format 编码
- 字段编号和类型必须与消息定义匹配
- 坐标值使用 little-endian 双精度浮点数
- 事件 ID 可以设置为 0（不影响功能）
- 按钮状态和事件类型必须匹配

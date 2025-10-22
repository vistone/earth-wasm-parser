# Earth WASM Protobuf 消息类型 - 完整分析

## 📊 统计信息

从 `earthplugin_web.wasm` (20MB) 中提取的所有 Protobuf 消息定义。

- **总消息类型**: 3,789 个
- **命名空间数**: 455 个
- **文件大小**: 19,982,569 bytes (~20MB)

**完整列表**: 详见 [COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md)

## 🏆 主要命名空间（按消息数量排序）

| 命名空间 | 消息数量 | 用途 |
|---------|---------|------|
| `earth.document.protos` | 407 | 文档处理相关 |
| `geostore` | 276 | 地理数据存储 |
| `earth.state` | 133 | 地球状态管理 |
| `earth.state.derivedstate` | 104 | 派生状态 |
| `google.internal.earth.v1.builtenv` | 102 | 建筑环境 |
| `maps_paint` | 102 | 地图绘制 |
| `earth.featureupdater` | 96 | 功能更新器 |
| `geo.earth.proto` | 70 | 地理原型 |
| `quality_qrewrite` | 64 | 查询重写质量 |
| `google.internal.earth.v1` | 57 | Google Earth V1 |

## 🔥 核心功能命名空间

### earth.* (地球引擎核心 - 13 个消息)

**最重要的消息类型**:

- `InputEvent` - **输入事件（鼠标/键盘事件）** ⭐
  - 字段: `pointer_down`, `button`, `type`, `event_id`, `x`, `y`, `delta_x`, `delta_y`, `pointer_up`
  - 事件类型: 1=mousedown, 2=mouseup, 3=mousemove, 4=wheel
  - 用途: 地球旋转、缩放、平移控制

- `Camera` - 相机配置
- `KeyboardEvent` - 键盘事件
- `PointerEvent` - 指针事件
- `TouchPointer` - 触摸指针
- `Location` - 位置信息
- `Arguments` - 参数
- `ResizeEvent` - 调整大小事件

### google.protobuf (标准 Protobuf - 35 个消息)

- `Any` - 任意消息类型容器
- `BoolValue`, `Int32Value`, `Int64Value` - 值包装器
- `Timestamp`, `Duration` - 时间相关
- `Struct`, `Value`, `ListValue` - 动态类型
- `FieldMask` - 字段掩码
- `Empty` - 空消息

### google.api (Google API - 34 个消息)

- `Http`, `HttpRule` - HTTP 规则
- `HttpBody` - HTTP 消息体
- `Status` - 状态码
- `AuthProvider`, `AuthRequirement` - 认证

### maps_paint (地图绘制 - 102 个消息)

地图绘制和渲染相关的消息类型。

### geo_photo_service (地理照片服务 - 56 个消息)

地理照片相关的服务和数据。

### earth.state.* (状态管理 - 237 个消息)

地球引擎的状态管理系统，包括：
- `earth.state`: 133 个消息
- `earth.state.derivedstate`: 104 个消息

## 📝 重要消息格式

### earth.InputEvent (鼠标事件)

```protobuf
message InputEvent {
  bool pointer_down = 1;
  uint32 button = 2;        // 0=无按钮, 1=左键, 4=释放
  uint32 type = 3;          // 1=mousedown, 2=mouseup, 3=mousemove, 4=wheel
  uint32 event_id = 4;
  double x = 5;             // X 坐标
  double y = 6;             // Y 坐标
  double delta_x = 7;       // 滚轮 delta X
  double delta_y = 8;       // 滚轮 delta Y
  bool pointer_up = 10;
}
```

**Wire Format 编码示例**:
- mousedown: 28 bytes
- mousemove: 26 bytes
- mouseup: 28 bytes
- wheel: 46 bytes

详细编码方式参见 [WASM_FULL_ANALYSIS.md](./WASM_FULL_ANALYSIS.md)

## 🛠️ 使用说明

### 1. 查找消息类型

查看完整列表: `COMPLETE_PROTO_LIST.md`

### 2. 编码 Protobuf 消息

参考 `WASM_FULL_ANALYSIS.md` 中的 Wire Format 编码方式。

### 3. 调用 WASM 函数

参考 `WASM_API.md` 了解如何调用 WASM 模块的函数。

## 📚 相关文档

- [WASM_API.md](./WASM_API.md) - WASM 模块 API 使用指南
- [WASM_FULL_ANALYSIS.md](./WASM_FULL_ANALYSIS.md) - 完整的 WASM 分析
- [COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md) - 完整的 Protobuf 消息列表
- [ARCHITECTURE.md](./ARCHITECTURE.md) - 项目架构说明

## 🔍 消息命名规范

Protobuf 消息命名采用以下格式:

```
namespace.namespace.MessageName
```

例如:
- `earth.InputEvent` - earth 命名空间的 InputEvent 消息
- `google.protobuf.Any` - google.protobuf 命名空间的 Any 消息
- `earth.state.CameraState` - earth.state 命名空间的 CameraState 消息

## 📈 消息分类统计

- **地球引擎核心**: ~200 个消息
- **Google 标准**: ~120 个消息
- **地图绘制**: ~200 个消息
- **地理数据**: ~300 个消息
- **其他服务**: ~3000 个消息

## 🎯 下一步

1. 分析常用的消息类型结构
2. 提取字段定义和数据类型
3. 生成 TypeScript/Dart 类型定义
4. 实现消息序列化/反序列化工具

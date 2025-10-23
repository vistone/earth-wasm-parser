# 前端开发 API 参考文档

## 📋 概述

本文档列出了所有可用于前端开发的 Protobuf 接口，包括接口作用、参数说明和使用示例。

## 🎯 核心控制接口

### earth.InputEvent

**用途**: 控制地球的旋转、缩放、平移等操作

**参数**:
```protobuf
message InputEvent {
  bool pointer_down = 1;      // 指针按下状态
  uint32 button = 2;          // 按钮编号 (0=无, 1=左键, 4=释放)
  uint32 type = 3;            // 事件类型 (1=mousedown, 2=mouseup, 3=mousemove, 4=wheel)
  uint32 event_id = 4;        // 事件 ID
  double x = 5;               // X 坐标
  double y = 6;               // Y 坐标
  double delta_x = 7;         // 滚轮 delta X
  double delta_y = 8;         // 滚轮 delta Y
  bool pointer_up = 10;       // 指针释放状态
}
```

**使用示例**:
```javascript
// 发送鼠标按下事件
const data = encodeMouseDown(x, y);
Module.ReceiveViewModelCommand('earth.InputEvent', data);
```

### ResizeViewport

**用途**: 调整视口大小

**参数**:
- `width` (number) - 视口宽度
- `height` (number) - 视口高度

**使用示例**:
```javascript
Module.ResizeViewport(window.innerWidth, window.innerHeight);
```

## 🎮 相机控制接口

### LookAt

**用途**: 将相机对准指定位置

**参数**:
```protobuf
message LookAt {
  double latitude = 1;    // 纬度
  double longitude = 2;   // 经度
  double altitude = 3;   // 高度
  double range = 4;       // 视距
  double heading = 5;     // 方位角
  double tilt = 6;        // 倾斜角
  double roll = 7;        // 翻滚角
}
```

### LookFrom

**用途**: 设置相机位置

**参数**:
```protobuf
message LookFrom {
  double latitude = 1;    // 纬度
  double longitude = 2;   // 经度
  double altitude = 3;    // 高度
  double heading = 4;     // 方位角
  double tilt = 5;        // 倾斜角
  double roll = 6;        // 翻滚角
  double range = 7;       // 视距
}
```

### FlyToCamera

**用途**: 飞向指定相机位置

**参数**:
```protobuf
message FlyToCamera {
  Panorama panorama = 5;  // 全景信息
}
```

## 🔍 搜索相关接口

### PerformSearch

**用途**: 执行搜索

**参数**:
```protobuf
message PerformSearch {
  string query = 1;                        // 搜索查询
  string result_group_id = 2;              // 结果组 ID
  LatLonBox viewport = 3;                  // 视口范围
  bool suppress_fly_to_results = 4;        // 是否不飞向结果
}
```

### OpenKnowledgeCard

**用途**: 打开知识卡片

**参数**:
```protobuf
message OpenKnowledgeCard {
  PlaceMetadata metadata = 4;              // 地点元数据
}
```

## 📁 文档管理接口

### OpenKmlDocument

**用途**: 打开 KML 文档

**参数**:
- `document_key` - 文档键
- `fly_to_after_load` - 加载后是否飞向
- `resource_key` - 资源键

### CreatePointPlacemark

**用途**: 创建点标记

**参数**:
- `latitude` - 纬度
- `longitude` - 经度
- `name` - 名称
- `description` - 描述

### EditFeature

**用途**: 编辑要素

**参数**:
- `feature_id` - 要素 ID
- `properties` - 属性

### DeleteFeature

**用途**: 删除要素

**参数**:
- `feature_id` - 要素 ID

## 🎨 图层控制接口

### ToggleLayer

**用途**: 切换图层显示

**参数**:
- `layer_id` - 图层 ID
- `visible` - 是否可见

### SetBasemapStyle

**用途**: 设置底图样式

**参数**:
- `style` - 样式名称

## 🚀 时间相关接口

### EnterTimeMachine

**用途**: 进入时间机器模式

**参数**:
```protobuf
message EnterTimeMachine {
  string date = 1;                     // 日期
  bool expanded = 2;                   // 是否展开
  bool timelapse_enabled = 3;          // 时间流逝启用
  int32 timelapse_paused_at_year = 5; // 暂停年份
}
```

### EnterTimelapse

**用途**: 进入时间流逝模式

**参数**:
- `enabled` - 是否启用
- `start_date` - 开始日期
- `end_date` - 结束日期

## 🏗️ 设计相关接口（Earth Studio）

### RenderDesign

**用途**: 渲染设计

**参数**:
- `design_id` - 设计 ID
- `parameters` - 渲染参数

### ViewDesign

**用途**: 查看设计

**参数**:
- `design_id` - 设计 ID

### CreateDesigns

**用途**: 创建设计

**参数**:
- `design_spec` - 设计规格
- `inputs` - 输入参数

## 📊 状态管理接口

### SetHomescreenVisibility

**用途**: 设置主页屏幕可见性

**参数**:
- `visible` - 是否可见

### SetSearchState

**用途**: 设置搜索状态

**参数**:
- `query` - 查询字符串
- `results` - 搜索结果

## 🔗 深度链接接口

### HandleEarthDeepLink

**用途**: 处理 Earth 深度链接

**参数**:
- `url` - 深度链接 URL
- `parameters` - 链接参数

## 📝 使用流程

### 1. 初始化

```javascript
window.addEventListener('earth-wasm-started', () => {
  Module.canvas = document.getElementById('earth-canvas');
  Module.ccall("initialize", null, ["string"], [base64Init]);
});
```

### 2. 发送命令

```javascript
// 编码消息
const message = {
  pointer_down: true,
  button: 1,
  type: 1,  // mousedown
  x: 100,
  y: 200
};

// 调用接口
Module.ReceiveViewModelCommand('earth.InputEvent', encodeMessage(message));
```

### 3. 监听响应

```javascript
Module.onViewportResized = (width, height) => {
  console.log(`视口大小: ${width}x${height}`);
};
```

## 📚 相关文档

- [WASM_API.md](./WASM_API.md) - WASM API 完整文档
- [PROTO_USAGE_GUIDE.md](./PROTO_USAGE_GUIDE.md) - Protobuf 使用指南
- [WASM_FUNCTIONS_ANALYSIS.md](./WASM_FUNCTIONS_ANALYSIS.md) - 函数分析

## 💡 快速参考

### 消息类型编号

| 消息类型 | 用途 |
|---------|------|
| earth.InputEvent | 输入控制 |
| Camera | 相机设置 |
| Location | 位置信息 |
| PerformSearch | 搜索 |
| OpenKmlDocument | 打开文档 |
| ToggleLayer | 图层控制 |

### 常用字段类型

| 类型 | 说明 |
|------|------|
| bool | 布尔值 |
| uint32 | 无符号整数 |
| int32 | 有符号整数 |
| double | 双精度浮点数 |
| string | 字符串 |
| repeated | 数组/列表 |


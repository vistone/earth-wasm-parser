# 前端 API 深度分析文档

## 📋 概述

本文档深入分析每个接口的实际用途、参数含义和使用场景。

## 🎯 核心控制接口

### earth.InputEvent - 输入事件控制

**完整消息类型**: `earth.InputEvent`

**实际用途**: 
- 控制地球的旋转（拖动鼠标）
- 控制地球的缩放（滚轮）
- 控制地球的平移（shift+拖动）
- 处理触摸事件（移动设备）

**完整参数结构**:
```protobuf
message InputEvent {
  bool pointer_down = 1;      // 指针是否按下
  uint32 button = 2;          // 按钮状态
                              // 0 = 无按钮
                              // 1 = 左键按下
                              // 4 = 按钮释放
  uint32 type = 3;            // 事件类型
                              // 1 = mousedown (按下)
                              // 2 = mouseup (释放)
                              // 3 = mousemove (移动)
                              // 4 = wheel (滚轮)
  uint32 event_id = 4;        // 事件 ID（可用于追踪事件序列）
  double x = 5;               // X 坐标（像素）
  double y = 6;               // Y 坐标（像素）
  double delta_x = 7;         // 滚轮 delta X（像素）
  double delta_y = 8;         // 滚轮 delta Y（像素）
  bool pointer_up = 10;       // 指针是否释放
}
```

**使用场景**:
1. **旋转地球**: 按下左键并拖动
2. **缩放地球**: 滚动滚轮
3. **平移地球**: Shift + 拖动
4. **触摸控制**: 移动设备上的触摸手势

**编码示例**:
```javascript
// 鼠标按下事件（100, 200 位置）
function encodeMouseDown(x, y) {
  const buf = new ArrayBuffer(28);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag for nested message
  arr[1] = 26;  // length = 26 bytes
  arr[2] = 8;   // field 1: pointer_down (varint, wire type 0)
  arr[3] = 1;   // value: true (1)
  arr[4] = 16;  // field 2: button (varint, wire type 0)
  arr[5] = 1;   // value: 1 (left button)
  arr[6] = 24;  // field 3: type (varint, wire type 0)
  arr[7] = 1;   // value: 1 (mousedown)
  arr[8] = 32;  // field 4: event_id (varint, wire type 0)
  arr[9] = 0;   // value: 0
  arr[10] = 41; // field 5: x (double, wire type 1)
  view.setFloat64(11, x, true);   // little-endian
  arr[19] = 49; // field 6: y (double, wire type 1)
  view.setFloat64(20, y, true);   // little-endian
  
  return arr;
}
```

### ResizeViewport - 视口调整

**用途**: 当窗口大小改变时调整渲染区域

**参数**:
- `width` (number) - 视口宽度（像素）
- `height` (number) - 视口高度（像素）

**使用场景**:
- 窗口大小调整
- 全屏切换
- 移动设备横竖屏切换

**调用方式**:
```javascript
window.addEventListener('resize', () => {
  const width = window.innerWidth;
  const height = window.innerHeight;
  Module.ResizeViewport(width, height);
});
```

## 🔍 搜索接口深度分析

### PerformSearch - 执行搜索

**完整参数**:
```protobuf
message PerformSearch {
  optional string query = 1;                   // 搜索关键词
  optional string result_group_id = 2;          // 结果组 ID（用于分页）
  optional LatLonBox viewport = 3;              // 视口范围（缩小搜索范围）
  optional bool suppress_fly_to_results = 4;    // 是否不飞向结果
}

message LatLonBox {
  optional double north = 1;   // 北边界（纬度）
  optional double south = 2;   // 南边界（纬度）
  optional double east = 3;    // 东边界（经度）
  optional double west = 4;    // 西边界（经度）
}
```

**实际用途**:
- 搜索地点（如"北京天安门"）
- 搜索时指定区域范围（提高准确性）
- 控制是否自动飞向搜索结果

**使用示例**:
```javascript
// 搜索"北京"
const searchData = {
  query: "北京",
  suppress_fly_to_results: false  // 自动飞向结果
};

// 只在特定区域搜索
const localizedSearch = {
  query: "餐厅",
  viewport: {
    north: 39.95,
    south: 39.90,
    east: 116.42,
    west: 116.40
  }
};
```

### OpenKnowledgeCard - 打开知识卡片

**完整参数**:
```protobuf
message OpenKnowledgeCard {
  oneof place_id {
    string fid = 1;  // Feature ID
    string mid = 2;  // Map ID
  }
  optional PlaceMetadata metadata = 4;
  optional CardSize card_size = 5;
  optional bool fly_to_immediately = 3;
}

message PlaceMetadata {
  optional string query = 4;
  optional string layer_id = 5;
  oneof coordinates {
    LatLon lat_lon = 1;
  }
}

message LatLon {
  optional double latitude = 1;
  optional double longitude = 2;
}

enum CardSize {
  CARD_SIZE_COLLAPSED = 1;  // 折叠
  CARD_SIZE_NORMAL = 2;     // 正常
  CARD_SIZE_EXPANDED = 3;   // 展开
}
```

**使用场景**:
- 显示地点详细信息
- 查看地点的照片、评价等
- 导航到地点

## 📷 相机控制深度分析

### FlyToCamera - 飞向相机位置

**完整参数**:
```protobuf
message FlyToCamera {
  oneof camera_type {
    LookAt look_at = 1;      // 看向某个位置
    LookFrom look_from = 2;  // 从某个位置看
  }
  
  optional CameraAnimation camera_animation = 3;
  enum CameraAnimation {
    CAMERA_ANIMATION_TELEPORT = 1;  // 瞬间传送
    CAMERA_ANIMATION_FLY = 2;       // 飞行（有动画）
  }
  
  optional CameraPresentationMode camera_presentation_mode = 4;
  enum CameraPresentationMode {
    PRESENTATION_MODE_STATIC = 1;           // 静态视角
    PRESENTATION_MODE_POI_ORBIT = 2;        // 围绕 POI 环绕
    PRESENTATION_MODE_PLANET_ORBIT = 3;     // 围绕行星环绕
    PRESENTATION_MODE_CINEMATIC = 4;        // 电影模式
  }
  
  optional Panorama panorama = 5;
  optional bool disable_clamping = 6;  // 禁用高度限制
}

message LookAt {
  optional double latitude = 1;   // 目标纬度
  optional double longitude = 2;  // 目标经度
  optional double altitude = 3;   // 目标高度（米）
  optional double range = 4;      // 视距（米）
  optional double heading = 5;    // 方位角（度，0-360）
  optional double tilt = 6;       // 倾斜角（度，0-90）
  optional double roll = 7;       // 翻滚角（度）
  optional double fovy = 8;       // 视野角度（度）
}

message LookFrom {
  optional double latitude = 1;   // 相机纬度
  optional double longitude = 2; // 相机经度
  optional double altitude = 3;   // 相机高度
  optional double heading = 4;    // 朝向
  optional double tilt = 5;       // 倾斜
  optional double roll = 6;       // 翻滚
  optional double fovy = 7;      // 视野
}
```

**参数含义详解**:

| 参数 | 含义 | 取值范围 | 说明 |
|------|------|---------|------|
| `latitude` | 纬度 | -90 到 90 | 负数=南半球，正数=北半球 |
| `longitude` | 经度 | -180 到 180 | 负数=西经，正数=东经 |
| `altitude` | 高度 | 0 到 高度限制 | 米为单位 |
| `range` | 视距 | > 0 | 相机到目标的距离（米） |
| `heading` | 方位角 | 0-360 | 度，0=北，90=东，180=南，270=西 |
| `tilt` | 倾斜角 | 0-90 | 度，0=水平，90=垂直向下 |
| `roll` | 翻滚角 | -180 到 180 | 度，相机倾斜 |
| `fovy` | 视野角度 | 10-120 | 度，角度越大视野越广 |

**使用场景**:

1. **查看城市全景**:
```javascript
const camera = {
  look_at: {
    latitude: 39.9042,    // 北京
    longitude: 116.4074,
    altitude: 0,
    range: 10000,         // 10 公里高度
    heading: 0,           // 朝北
    tilt: 45              // 45度俯视
  },
  camera_animation: 2,   // 飞行模式
  camera_presentation_mode: 1  // 静态
};
```

2. **围绕地标旋转**:
```javascript
const orbit = {
  look_at: {
    latitude: 39.9042,
    longitude: 116.4074,
    range: 5000
  },
  camera_presentation_mode: 2  // POI 环绕
};
```

## 📁 文档和要素管理

### OpenKmlDocument - 打开 KML 文档

**参数**:
- `uri` (string) - KML 文档的 URI 或 URL

**支持格式**:
- 本地文件路径
- HTTP/HTTPS URL
- Google Drive 链接

**使用场景**:
- 加载自定义 KML 文件
- 打开保存的项目
- 导入地理数据

### CreatePointPlacemark - 创建点标记

**完整参数**:
```protobuf
message CreatePointPlacemark {
  optional LatLngAlt lat_lng_alt = 1;
  optional AltitudeMode altitude_mode = 2;
}

message LatLngAlt {
  optional double latitude = 1;
  optional double longitude = 2;
  optional double altitude = 3;
}

enum AltitudeMode {
  CLAMP_TO_GROUND = 0;     // 贴地
  RELATIVE_TO_GROUND = 1;  // 相对地面
  ABSOLUTE = 2;            // 绝对高度
}
```

**使用场景**:
- 在地图上标记位置
- 添加自定义地点
- 创建兴趣点

### EditFeature / DeleteFeature - 编辑/删除要素

**编辑要素参数**:
```protobuf
message EditFeature {
  optional int32 document_key = 1;     // 文档键
  optional string feature_id = 2;      // 要素 ID
  optional FeatureProperties feature_properties = 3;  // 新属性
}
```

**删除要素参数**:
```protobuf
message DeleteFeature {
  optional int32 document_key = 1;
  optional string feature_id = 2;
}
```

## 🏢 图层控制

### ToggleLayer - 切换图层

**完整参数**:
```protobuf
message ToggleLayer {
  optional LayerType layer_type = 1;
  optional bool enabled = 2;
}

enum LayerType {
  LAYER_TYPE_3D_BUILDINGS = 1;          // 3D 建筑
  LAYER_TYPE_TIMELAPSE = 2;             // 时间流逝
  LAYER_TYPE_RECENTLY_UPDATED = 3;      // 最近更新
  LAYER_TYPE_3D_COVERAGE = 4;           // 3D 覆盖
  LAYER_TYPE_PHOTOS = 5;                // 照片
  LAYER_TYPE_GRIDLINES = 6;             // 网格线
  LAYER_TYPE_ANIMATED_CLOUDS = 7;      // 动画云
  LAYER_TYPE_PINNED_PROJECTS = 10;      // 固定项目
}
```

**使用场景**:
- 显示/隐藏 3D 建筑
- 控制照片图层
- 切换网格线显示
- 控制云层动画

## ⏰ 时间相关

### EnterTimeMachine - 进入时间机器

**完整参数**:
```protobuf
message EnterTimeMachine {
  optional string date = 1;                          // 日期 (YYYY-MM-DD)
  optional bool expanded = 2;                         // 时间条是否展开
  optional bool timelapse_enabled = 3;               // 是否启用时间流逝
  optional double timelapse_framerate_multiplier = 4; // 帧率倍数
  optional int32 timelapse_paused_at_year = 5;       // 暂停年份
}
```

**使用场景**:
- 查看历史图像
- 播放城市发展过程
- 对比不同时期的地貌

## 🔧 嵌套消息详解

### Location - 位置信息

```protobuf
message Location {
  optional double longitude = 2;  // 经度
  optional double latitude = 3;    // 纬度
  optional double altitude = 1;    // 高度（米）
}
```

### Rotation - 旋转信息

```protobuf
message Rotation {
  optional float heading = 1;  // 方位角（度）
  optional float tilt = 2;     // 倾斜角（度）
  optional float roll = 3;     // 翻滚角（度）
}
```

### Size - 尺寸信息

```protobuf
message Size {
  optional int32 width = 1;   // 宽度（像素）
  optional int32 height = 2;  // 高度（像素）
}
```

## 💡 实际使用案例

### 案例 1: 完整的搜索和查看流程

```javascript
// 1. 执行搜索
const searchCmd = {
  query: "北京天安门",
  suppress_fly_to_results: false
};
Module.ReceiveViewModelCommand('geo.earth.proto.PerformSearch', encode(searchCmd));

// 2. 等待搜索结果后，打开知识卡片
const cardCmd = {
  fid: "天安门_place_id",
  card_size: 2,  // NORMAL
  fly_to_immediately: true
};
Module.ReceiveViewModelCommand('geo.earth.proto.OpenKnowledgeCard', encode(cardCmd));

// 3. 飞向位置并调整视角
const flyCmd = {
  look_at: {
    latitude: 39.9042,
    longitude: 116.4074,
    altitude: 0,
    range: 500,
    heading: 0,
    tilt: 45
  },
  camera_animation: 2  // FLY
};
Module.ReceiveViewModelCommand('geo.earth.proto.FlyToCamera', encode(flyCmd));
```

### 案例 2: 创建和编辑标记

```javascript
// 1. 创建标记
const createCmd = {
  lat_lng_alt: {
    latitude: 39.9042,
    longitude: 116.4074,
    altitude: 0
  },
  altitude_mode: 0  // CLAMP_TO_GROUND
};
Module.ReceiveViewModelCommand('geo.earth.proto.CreatePointPlacemark', encode(createCmd));

// 2. 编辑标记（假设获得了 feature_id）
const editCmd = {
  document_key: 1,
  feature_id: "feature_123",
  feature_properties: {
    name: "我的标记",
    description: "这是一个测试标记"
  }
};
Module.ReceiveViewModelCommand('geo.earth.proto.EditFeature', encode(editCmd));
```

### 案例 3: 时间流逝视图

```javascript
// 启用时间流逝模式
const timelapseCmd = {
  enabled: true,
  expanded: true,
  framerate_multiplier: 1.0,
  paused_at_year: 2020
};
Module.ReceiveViewModelCommand('geo.earth.proto.EnterTimelapse', encode(timelapseCmd));

// 设置特定日期
const timeMachineCmd = {
  date: "2010-01-01",
  expanded: true,
  timelapse_enabled: true
};
Module.ReceiveViewModelCommand('geo.earth.proto.EnterTimeMachine', encode(timeMachineCmd));
```

## 📚 编码辅助库

为了方便使用，建议创建编码辅助函数：

```javascript
// Protobuf 编码库
class ProtoEncoder {
  // 编码鼠标事件
  static encodeInputEvent(type, x, y, button = 1) {
    // ... 实现
  }
  
  // 编码搜索命令
  static encodePerformSearch(query, options = {}) {
    // ... 实现
  }
  
  // 编码相机命令
  static encodeFlyToCamera(position, options = {}) {
    // ... 实现
  }
  
  // 编码图层切换
  static encodeToggleLayer(layerType, enabled) {
    // ... 实现
  }
}

// 使用
const data = ProtoEncoder.encodeInputEvent(1, 100, 200);
Module.ReceiveViewModelCommand('earth.InputEvent', data);
```

## 🔗 相关文档

- [FRONTEND_API_COMPLETE.md](./FRONTEND_API_COMPLETE.md) - 完整接口列表
- [FRONTEND_API_QUICK_REFERENCE.md](./FRONTEND_API_QUICK_REFERENCE.md) - 快速参考
- [WASM_API.md](./WASM_API.md) - WASM API 文档


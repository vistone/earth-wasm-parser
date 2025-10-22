# 前端开发接口完整文档

## 📋 使用说明

所有接口通过 `Module.ReceiveViewModelCommand()` 调用，第一个参数是消息类型名称，第二个参数是 Protobuf 编码的数据。

## 🎮 输入控制

### earth.InputEvent

**消息类型**: `earth.InputEvent`

**用途**: 鼠标、键盘、触摸事件控制

**参数**:
```protobuf
message InputEvent {
  bool pointer_down = 1;      // 指针按下
  uint32 button = 2;          // 按钮 (0=无, 1=左键, 4=释放)
  uint32 type = 3;            // 类型 (1=mousedown, 2=mouseup, 3=mousemove, 4=wheel)
  uint32 event_id = 4;        // 事件 ID
  double x = 5;               // X 坐标
  double y = 6;               // Y 坐标
  double delta_x = 7;         // 滚轮 delta X
  double delta_y = 8;         // 滚轮 delta Y
  bool pointer_up = 10;       // 指针释放
}
```

**示例**: 发送鼠标按下事件
```javascript
const data = encodeMouseDown(100, 200);
Module.ReceiveViewModelCommand('earth.InputEvent', data);
```

## 🔍 搜索相关

### 1. PerformSearch

**消息类型**: `geo.earth.proto.PerformSearch`

**用途**: 执行搜索查询

**参数**:
- `query` (string) - 搜索关键词
- `result_group_id` (string) - 结果组 ID
- `viewport` (LatLonBox) - 视口范围
  - `north` (double) - 北边界
  - `south` (double) - 南边界
  - `east` (double) - 东边界
  - `west` (double) - 西边界
- `suppress_fly_to_results` (bool) - 是否不飞向结果

**示例**:
```javascript
const searchData = {
  query: "北京天安门",
  suppress_fly_to_results: false
};
Module.ReceiveViewModelCommand('geo.earth.proto.PerformSearch', encode(searchData));
```

### 2. OpenKnowledgeCard

**消息类型**: `geo.earth.proto.OpenKnowledgeCard`

**用途**: 打开知识卡片

**参数**:
- `place_id` (string) - 地点 ID (fid 或 mid)
- `metadata` (PlaceMetadata) - 地点元数据
  - `query` (string) - 查询词
  - `layer_id` (string) - 图层 ID
  - `coordinates` (LatLon) - 坐标
    - `latitude` (double) - 纬度
    - `longitude` (double) - 经度
- `card_size` (enum) - 卡片大小
  - `CARD_SIZE_COLLAPSED` (1) - 折叠
  - `CARD_SIZE_NORMAL` (2) - 正常
  - `CARD_SIZE_EXPANDED` (3) - 展开
- `fly_to_immediately` (bool) - 是否立即飞向

**示例**:
```javascript
const cardData = {
  fid: "place_id_123",
  card_size: 2,  // NORMAL
  fly_to_immediately: true
};
Module.ReceiveViewModelCommand('geo.earth.proto.OpenKnowledgeCard', encode(cardData));
```

### 3. ClearSearchHistory

**消息类型**: `geo.earth.proto.ClearSearchHistory`

**用途**: 清除搜索历史

**参数**: 无

### 4. OpenSearchHistory

**消息类型**: `geo.earth.proto.OpenSearchHistory`

**用途**: 打开搜索历史

**参数**: 无

## 📷 相机控制

### 1. FlyToCamera

**消息类型**: `geo.earth.proto.FlyToCamera`

**用途**: 飞向指定相机位置

**参数**:
- `camera_type` (oneof) - 相机类型
  - `look_at` (LookAt) - 看向位置
    - `latitude` (double) - 纬度
    - `longitude` (double) - 经度
    - `altitude` (double) - 高度
    - `range` (double) - 视距
    - `heading` (double) - 方位角
    - `tilt` (double) - 倾斜角
    - `roll` (double) - 翻滚角
    - `fovy` (double) - 视野角度
  - `look_from` (LookFrom) - 从位置
    - `latitude` (double) - 纬度
    - `longitude` (double) - 经度
    - `altitude` (double) - 高度
    - `heading` (double) - 方位角
    - `tilt` (double) - 倾斜角
    - `roll` (double) - 翻滚角
    - `fovy` (double) - 视野角度
- `camera_animation` (enum) - 动画类型
  - `CAMERA_ANIMATION_TELEPORT` (1) - 瞬间传送
  - `CAMERA_ANIMATION_FLY` (2) - 飞行
- `camera_presentation_mode` (enum) - 展示模式
  - `PRESENTATION_MODE_STATIC` (1) - 静态
  - `PRESENTATION_MODE_POI_ORBIT` (2) - POI 环绕
  - `PRESENTATION_MODE_PLANET_ORBIT` (3) - 行星环绕
  - `PRESENTATION_MODE_CINEMATIC` (4) - 电影模式
- `panorama` (Panorama) - 全景信息
  - `pano_id` (string) - 全景 ID
  - `front_end` (enum) - 前端类型
- `disable_clamping` (bool) - 禁用夹紧

**示例**:
```javascript
const cameraData = {
  look_at: {
    latitude: 39.9042,
    longitude: 116.4074,
    altitude: 0,
    range: 1000,
    heading: 0,
    tilt: 45,
    roll: 0
  },
  camera_animation: 2,  // FLY
  camera_presentation_mode: 1  // STATIC
};
Module.ReceiveViewModelCommand('geo.earth.proto.FlyToCamera', encode(cameraData));
```

## 📁 文档管理

### 1. OpenKmlDocument

**消息类型**: `geo.earth.proto.OpenKmlDocument`

**用途**: 打开 KML 文档

**参数**:
- `uri` (string) - 文档 URI

### 2. OpenCloudProject

**消息类型**: `geo.earth.proto.OpenCloudProject`

**用途**: 打开云端项目

**参数**:
- `project_id` (string) - 项目 ID
- `fly_to_after_load` (bool) - 加载后是否飞向
- `resource_key` (string) - 资源键
- `document_namespace` (enum) - 文档命名空间
- `open_mode` (PresentMode) - 打开模式
  - `feature_id` (string) - 要素 ID

### 3. CreateCloudProject

**消息类型**: `geo.earth.proto.CreateCloudProject`

**用途**: 创建云端项目

**参数**:
- `folder_id` (string) - 文件夹 ID

### 4. OpenProjectByKey

**消息类型**: `geo.earth.proto.OpenProjectByKey`

**用途**: 通过键打开项目

**参数**:
- `document_key` (int32) - 文档键
- `fly_to_after_load` (bool) - 加载后是否飞向

## 🎨 要素操作

### 1. CreatePointPlacemark

**消息类型**: `geo.earth.proto.CreatePointPlacemark`

**用途**: 创建点标记

**参数**:
- `lat_lng_alt` (LatLngAlt) - 位置
  - `latitude` (double) - 纬度
  - `longitude` (double) - 经度
  - `altitude` (double) - 高度
- `altitude_mode` (enum) - 高度模式
  - `CLAMP_TO_GROUND` - 贴地

**示例**:
```javascript
const placemarkData = {
  lat_lng_alt: {
    latitude: 39.9042,
    longitude: 116.4074,
    altitude: 0
  },
  altitude_mode: 0  // CLAMP_TO_GROUND
};
Module.ReceiveViewModelCommand('geo.earth.proto.CreatePointPlacemark', encode(placemarkData));
```

### 2. CreateFeature

**消息类型**: `geo.earth.proto.CreateFeature`

**用途**: 创建要素

**参数**:
- `feature_properties` - 要素属性
- `feature_style` - 要素样式
- `document_key` (int32) - 文档键

### 3. EditFeature

**消息类型**: `geo.earth.proto.EditFeature`

**用途**: 编辑要素

**参数**:
- `document_key` (int32) - 文档键
- `feature_id` (string) - 要素 ID
- `feature_properties` - 要素属性

### 4. DeleteFeature

**消息类型**: `geo.earth.proto.DeleteFeature`

**用途**: 删除要素

**参数**:
- `document_key` (int32) - 文档键
- `feature_id` (string) - 要素 ID

## 🏢 图层控制

### 1. ToggleLayer

**消息类型**: `geo.earth.proto.ToggleLayer`

**用途**: 切换图层显示

**参数**:
- `layer_type` (enum) - 图层类型
  - `LAYER_TYPE_3D_BUILDINGS` (1) - 3D 建筑
  - `LAYER_TYPE_TIMELAPSE` (2) - 时间流逝
  - `LAYER_TYPE_RECENTLY_UPDATED` (3) - 最近更新
  - `LAYER_TYPE_3D_COVERAGE` (4) - 3D 覆盖
  - `LAYER_TYPE_PHOTOS` (5) - 照片
  - `LAYER_TYPE_GRIDLINES` (6) - 网格线
  - `LAYER_TYPE_ANIMATED_CLOUDS` (7) - 动画云
  - `LAYER_TYPE_PINNED_PROJECTS` (10) - 固定项目
- `enabled` (bool) - 是否启用

**示例**:
```javascript
const layerData = {
  layer_type: 1,  // 3D_BUILDINGS
  enabled: true
};
Module.ReceiveViewModelCommand('geo.earth.proto.ToggleLayer', encode(layerData));
```

### 2. SetBasemapStyle

**消息类型**: `geo.earth.proto.SetBasemapStyle`

**用途**: 设置底图样式

**参数**:
- `imagery` (enum) - 图像类型

### 3. ToggleAvailableLayersUi

**消息类型**: `geo.earth.proto.ToggleAvailableLayersUi`

**用途**: 切换可用图层 UI

**参数**:
- `open_data_catalog` (bool) - 是否打开数据目录

## ⏰ 时间相关

### 1. EnterTimeMachine

**消息类型**: `geo.earth.proto.EnterTimeMachine`

**用途**: 进入时间机器模式

**参数**:
- `date` (string) - 日期
- `expanded` (bool) - 是否展开
- `timelapse_enabled` (bool) - 时间流逝启用
- `timelapse_framerate_multiplier` (double) - 帧率倍数
- `timelapse_paused_at_year` (int32) - 暂停年份

**示例**:
```javascript
const timeMachineData = {
  date: "2020-01-01",
  expanded: true,
  timelapse_enabled: true,
  timelapse_framerate_multiplier: 1.0,
  timelapse_paused_at_year: 2020
};
Module.ReceiveViewModelCommand('geo.earth.proto.EnterTimeMachine', encode(timeMachineData));
```

### 2. EnterTimelapse

**消息类型**: `geo.earth.proto.EnterTimelapse`

**用途**: 进入时间流逝模式

**参数**:
- `enabled` (bool) - 是否启用
- `expanded` (bool) - 是否展开
- `framerate_multiplier` (double) - 帧率倍数
- `paused_at_year` (int32) - 暂停年份

## 🌐 街景

### EnterStreetView

**消息类型**: `geo.earth.proto.EnterStreetView`

**用途**: 进入街景模式

**参数**:
- `lat_lng_alt` (LatLngAlt) - 位置
  - `latitude` (double) - 纬度
  - `longitude` (double) - 经度
  - `altitude` (double) - 高度

## 🏗️ 设计相关（Earth Studio）

### 1. ViewDesign

**消息类型**: `geo.earth.proto.ViewDesign`

**用途**: 查看设计

**参数**:
- `selected_design_id` (string) - 选中的设计 ID
- `is_design_details_open` (bool) - 设计详情是否打开
- `is_design_viewer_open` (bool) - 设计查看器是否打开

### 2. CreateDesigns

**消息类型**: `geo.earth.proto.CreateDesigns`

**用途**: 创建设计

**参数**:
- `design_input_mode` (enum) - 设计输入模式
  - `DESIGN_INPUT_MODE_NEW_BUILD` (1) - 新建建筑
  - `DESIGN_INPUT_MODE_SOLAR` (2) - 太阳能

## 📱 UI 控制

### SetHomescreenVisibility

**消息类型**: `geo.earth.proto.SetHomescreenVisibility`

**用途**: 设置主页屏幕可见性

**参数**:
- `is_open` (bool) - 是否打开

## 📝 编码辅助函数

```javascript
// 编码鼠标按下事件
function encodeMouseDown(x, y) {
  const buf = new ArrayBuffer(28);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag
  arr[1] = 26;  // length
  arr[2] = 8;   // pointer_down = true
  arr[3] = 1;
  arr[4] = 16;  // button = 1 (left)
  arr[5] = 1;
  arr[6] = 24;  // type = 1 (mousedown)
  arr[7] = 1;
  arr[8] = 32;  // event_id = 0
  arr[9] = 0;
  arr[10] = 41; // x coordinate
  view.setFloat64(11, x, true);
  arr[19] = 49; // y coordinate
  view.setFloat64(20, y, true);
  
  return arr;
}

// 编码鼠标移动事件
function encodeMouseMove(x, y) {
  const buf = new ArrayBuffer(26);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag
  arr[1] = 24;  // length
  arr[2] = 8;   // pointer_down = true
  arr[3] = 1;
  arr[4] = 16;  // button = 0
  arr[5] = 0;
  arr[6] = 24;  // type = 3 (mousemove)
  arr[7] = 3;
  arr[8] = 41;  // x coordinate
  view.setFloat64(9, x, true);
  arr[17] = 49; // y coordinate
  view.setFloat64(18, y, true);
  
  return arr;
}

// 编码滚轮事件
function encodeWheel(x, y, deltaX, deltaY) {
  const buf = new ArrayBuffer(46);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag
  arr[1] = 44;  // length
  arr[2] = 8;   // pointer_down = true
  arr[3] = 1;
  arr[4] = 16;  // button = 0
  arr[5] = 0;
  arr[6] = 24;  // type = 4 (wheel)
  arr[7] = 4;
  arr[8] = 41;  // x coordinate
  view.setFloat64(9, x, true);
  arr[17] = 49; // y coordinate
  view.setFloat64(18, y, true);
  arr[26] = 57; // delta_x
  view.setFloat64(27, deltaX, true);
  arr[35] = 65; // delta_y
  view.setFloat64(36, deltaY, true);
  arr[44] = 80; // pointer_up = true
  arr[45] = 1;
  
  return arr;
}
```

## 🔗 相关文档

- [WASM_API.md](./WASM_API.md) - WASM API 文档
- [PROTO_USAGE_GUIDE.md](./PROTO_USAGE_GUIDE.md) - Protobuf 使用指南
- [ANALYSIS_SUMMARY.md](./ANALYSIS_SUMMARY.md) - 分析总结


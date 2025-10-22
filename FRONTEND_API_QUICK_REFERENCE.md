# 前端 API 快速参考

## 🔍 按功能查找接口

### 🖱️ 输入控制
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **InputEvent** | `earth.InputEvent` | 鼠标/键盘/触摸事件 | x, y, type |

### 🔍 搜索
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **PerformSearch** | `geo.earth.proto.PerformSearch` | 执行搜索 | query |
| **OpenKnowledgeCard** | `geo.earth.proto.OpenKnowledgeCard` | 打开知识卡片 | fid/mid |
| **ClearSearchHistory** | `geo.earth.proto.ClearSearchHistory` | 清除搜索历史 | 无 |

### 📷 相机控制
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **FlyToCamera** | `geo.earth.proto.FlyToCamera` | 飞向相机位置 | look_at, camera_animation |
| **ResizeViewport** | - | 调整视口大小 | width, height |

### 📁 文档管理
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **OpenKmlDocument** | `geo.earth.proto.OpenKmlDocument` | 打开 KML 文档 | uri |
| **OpenCloudProject** | `geo.earth.proto.OpenCloudProject` | 打开云端项目 | project_id |
| **CreateCloudProject** | `geo.earth.proto.CreateCloudProject` | 创建云端项目 | folder_id |

### ✏️ 要素操作
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **CreatePointPlacemark** | `geo.earth.proto.CreatePointPlacemark` | 创建点标记 | lat_lng_alt |
| **CreateFeature** | `geo.earth.proto.CreateFeature` | 创建要素 | feature_properties |
| **EditFeature** | `geo.earth.proto.EditFeature` | 编辑要素 | feature_id, feature_properties |
| **DeleteFeature** | `geo.earth.proto.DeleteFeature` | 删除要素 | feature_id |

### 🏢 图层控制
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **ToggleLayer** | `geo.earth.proto.ToggleLayer` | 切换图层 | layer_type, enabled |
| **SetBasemapStyle** | `geo.earth.proto.SetBasemapStyle` | 设置底图样式 | imagery |

### ⏰ 时间相关
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **EnterTimeMachine** | `geo.earth.proto.EnterTimeMachine` | 进入时间机器 | date, timelapse_enabled |
| **EnterTimelapse** | `geo.earth.proto.EnterTimelapse` | 进入时间流逝 | enabled |

### 🌐 街景
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **EnterStreetView** | `geo.earth.proto.EnterStreetView` | 进入街景 | lat_lng_alt |

### 🏗️ 设计（Earth Studio）
| 接口 | 消息类型 | 用途 | 常用参数 |
|------|---------|------|---------|
| **ViewDesign** | `geo.earth.proto.ViewDesign` | 查看设计 | selected_design_id |
| **CreateDesigns** | `geo.earth.proto.CreateDesigns` | 创建设计 | design_input_mode |

## 📋 常用枚举值

### InputEvent 事件类型
- `1` - mousedown (鼠标按下)
- `2` - mouseup (鼠标释放)
- `3` - mousemove (鼠标移动)
- `4` - wheel (滚轮)

### ToggleLayer 图层类型
- `1` - LAYER_TYPE_3D_BUILDINGS (3D 建筑)
- `2` - LAYER_TYPE_TIMELAPSE (时间流逝)
- `5` - LAYER_TYPE_PHOTOS (照片)
- `7` - LAYER_TYPE_ANIMATED_CLOUDS (动画云)

### FlyToCamera 动画类型
- `1` - CAMERA_ANIMATION_TELEPORT (瞬间传送)
- `2` - CAMERA_ANIMATION_FLY (飞行)

## 💡 快速使用示例

### 发送鼠标事件
```javascript
// 按下
const down = encodeMouseDown(100, 200);
Module.ReceiveViewModelCommand('earth.InputEvent', down);

// 移动
const move = encodeMouseMove(150, 250);
Module.ReceiveViewModelCommand('earth.InputEvent', move);

// 释放
const up = encodeMouseUp(150, 250);
Module.ReceiveViewModelCommand('earth.InputEvent', up);

// 滚轮
const wheel = encodeWheel(100, 200, 0, 10);
Module.ReceiveViewModelCommand('earth.InputEvent', wheel);
```

### 搜索地点
```javascript
const search = encodeProtobuf({
  query: "北京天安门",
  suppress_fly_to_results: false
});
Module.ReceiveViewModelCommand('geo.earth.proto.PerformSearch', search);
```

### 飞向位置
```javascript
const flyTo = encodeProtobuf({
  look_at: {
    latitude: 39.9042,
    longitude: 116.4074,
    range: 1000,
    tilt: 45
  },
  camera_animation: 2  // FLY
});
Module.ReceiveViewModelCommand('geo.earth.proto.FlyToCamera', flyTo);
```

### 切换图层
```javascript
const toggle = encodeProtobuf({
  layer_type: 1,  // 3D_BUILDINGS
  enabled: true
});
Module.ReceiveViewModelCommand('geo.earth.proto.ToggleLayer', toggle);
```

## 📚 详细文档

- [FRONTEND_API_COMPLETE.md](./FRONTEND_API_COMPLETE.md) - 完整接口文档
- [WASM_API.md](./WASM_API.md) - WASM API 文档
- [PROTO_USAGE_GUIDE.md](./PROTO_USAGE_GUIDE.md) - Protobuf 使用指南

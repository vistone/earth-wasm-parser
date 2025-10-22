# WASM 完整接口和 Protobuf 分析

## 1. WASM 导出函数映射

从 `assignWasmExports` 函数提取的映射关系：

| WASM 导出名 | 真实函数名 | 说明 |
|------------|----------|------|
| gg | `_pthread_self` | 获取当前线程 ID |
| hg | `_main` | 主入口函数 |
| ig | `_initialize` | 初始化函数 |
| jg | `_malloc` | 分配内存 |
| kg | `_free` | 释放内存 |
| lg | `___getTypeName` | 获取类型名称 |
| mg | `__embind_initialize_bindings` | 初始化绑定 |
| ng | `__emscripten_tls_init` | TLS 初始化 |
| og | `_emscripten_builtin_memalign` | 内存对齐分配 |
| pg | `__emscripten_run_callback_on_thread` | 在线程上运行回调 |
| qg | `__emscripten_thread_init` | 线程初始化 |
| rg | `__emscripten_thread_crashed` | 线程崩溃处理 |
| sg | `__emscripten_run_js_on_main_thread` | 在主线程运行 JS |
| tg | `__emscripten_thread_free_data` | 释放线程数据 |
| ug | `__emscripten_thread_exit` | 线程退出 |
| vg | `__emscripten_check_mailbox` | 检查邮箱 |
| wg | `_setThrew` | 设置异常 |
| xg | `__emscripten_tempret_set` | 设置临时返回值 |
| yg | `_emscripten_stack_set_limits` | 设置栈限制 |
| zg | `__emscripten_stack_restore` | 恢复栈 |
| Ag | `__emscripten_stack_alloc` | 分配栈空间 |
| Bg | `_emscripten_stack_get_current` | 获取当前栈 |
| Cg~Zg, _g | 动态调用函数（dynCall_*） | 不同签名的函数调用 |

## 2. Module 对象可用函数

从代码分析得到：

### 核心函数
- `Module["ccall"]` - C 函数调用
- `Module["cwrap"]` - C 函数包装
- `Module["_initialize"]` - 初始化
- `Module["_main"]` - 主函数
- `Module["_malloc"]` - 内存分配
- `Module["ResizeViewport"]` - 调整视口
- `Module["ReceiveViewModelCommand"]` - 接收视图模型命令

### 文件系统
- `Module["FS_createDataFile"]` - 创建数据文件
- `Module["FS_createDevice"]` - 创建设备
- `Module["FS_createLazyFile"]` - 创建延迟加载文件
- `Module["FS_createPath"]` - 创建路径
- `Module["FS_preloadFile"]` - 预加载文件
- `Module["FS_unlink"]` - 删除文件

### 渲染相关
- `Module["GL"]` - WebGL 上下文
- `Module["ctx"]` - Canvas 上下文
- `Module["labelRenderer"]` - 标签渲染器
- `Module["canvas"]` - Canvas 元素

### 事件和回调
- `Module["pauseMainLoop"]` - 暂停主循环
- `Module["resumeMainLoop"]` - 恢复主循环
- `Module["requestAnimationFrame"]` - 请求动画帧
- `Module["addRunDependency"]` - 添加运行依赖
- `Module["removeRunDependency"]` - 移除运行依赖

## 3. Protobuf 消息格式分析

### earth.InputEvent 消息结构

根据手动注入代码分析，`earth.InputEvent` 使用 Protobuf 编码：

#### 字段定义（推测）

```protobuf
message InputEvent {
  // 字段1: 布尔值（可能是某个标志）
  optional bool field1 = 1;
  
  // 字段2: 按钮状态（0=无按钮, 1=左键, 2=右键, 4=释放）
  optional int32 button_state = 2;
  
  // 字段3: 事件类型（1=mousedown, 2=mouseup, 3=mousemove, 4=wheel）
  optional int32 event_type = 3;
  
  // 字段5: X 坐标（double）
  optional double x = 5;
  
  // 字段6: Y 坐标（double）
  optional double y = 6;
  
  // 字段7: 滚轮 delta X（double，仅 wheel 事件）
  optional double delta_x = 7;
  
  // 字段8: 滚轮 delta Y（double，仅 wheel 事件）
  optional double delta_y = 8;
  
  // 字段10: 布尔值（可能是另一个标志）
  optional bool field10 = 10;
}
```

### 编码实现（JavaScript）

#### mousedown (28 字节)
```javascript
function encodeMouseDown(x, y, button) {
  const buf = new ArrayBuffer(28);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag (wire type + field number)
  arr[1] = 26;  // length = 26
  arr[2] = 8;   // field 1 (bool)
  arr[3] = 1;   // value: true
  arr[4] = 16;  // field 2 (int32)
  arr[5] = button; // 0=左键, 1=中键, 2=右键
  arr[6] = 24;  // field 3 (int32)
  arr[7] = 1;   // value: 1 (mousedown)
  arr[8] = 32;  // field 4 (可能是其他标志)
  arr[9] = 0;
  arr[10] = 41; // field 5 (double)
  view.setFloat64(11, x, true);   // X coordinate
  arr[19] = 49; // field 6 (double)
  view.setFloat64(20, y, true);   // Y coordinate
  
  return arr;
}
```

#### mousemove (26 字节)
```javascript
function encodeMouseMove(x, y) {
  const buf = new ArrayBuffer(26);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag
  arr[1] = 24;  // length = 24
  arr[2] = 8;   // field 1
  arr[3] = 1;   // value: 1
  arr[4] = 16;  // field 2
  arr[5] = 0;   // value: 0 (no button)
  arr[6] = 24;  // field 3
  arr[7] = 3;   // value: 3 (mousemove)
  arr[8] = 41;  // field 5, type double
  view.setFloat64(9, x, true);   // X coordinate
  arr[17] = 49; // field 6, type double
  view.setFloat64(18, y, true);  // Y coordinate
  
  return arr;
}
```

#### mouseup (28 字节)
```javascript
function encodeMouseUp(x, y) {
  const buf = new ArrayBuffer(28);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;
  arr[1] = 26;
  arr[2] = 8;
  arr[3] = 1;
  arr[4] = 16;
  arr[5] = 4;   // button state = 4 (release)
  arr[6] = 24;
  arr[7] = 2;   // value: 2 (mouseup)
  arr[8] = 32;
  arr[9] = 0;
  arr[10] = 41;
  view.setFloat64(11, x, true);
  arr[19] = 49;
  view.setFloat64(20, y, true);
  
  return arr;
}
```

#### wheel (46 字节)
```javascript
function encodeWheel(x, y, deltaX, deltaY) {
  const buf = new ArrayBuffer(46);
  const view = new DataView(buf);
  const arr = new Uint8Array(buf);
  
  arr[0] = 18;  // field tag
  arr[1] = 44;  // length = 44
  arr[2] = 8;   // field 1
  arr[3] = 1;   // value: 1
  arr[4] = 16;  // field 2
  arr[5] = 0;   // value: 0
  arr[6] = 24;  // field 3
  arr[7] = 4;   // value: 4 (wheel event type)
  arr[8] = 41;  // field 5, type double
  view.setFloat64(9, x, true);   // X coordinate
  arr[17] = 49; // field 6, type double
  view.setFloat64(18, y, true);  // Y coordinate
  arr[26] = 57; // field 7, type double
  view.setFloat64(27, deltaX, true);  // wheel delta X
  arr[35] = 65; // field 8, type double
  view.setFloat64(36, deltaY, true);  // wheel delta Y
  arr[44] = 80; // field 10
  arr[45] = 1;  // value: 1
  
  return arr;
}
```

## 4. 为什么需要手动注入鼠标事件

### 关键发现

从 `wasm/plugins_compiled.js` 分析：

```javascript
Yc.prototype.Bn=function(a,b){
  var c=window.Module;
  (c=c?c.ReceiveViewModelCommand:null)&&c(a,b)
}
```

**结论**：
1. WASM 模块提供 `ReceiveViewModelCommand` 函数接口
2. 但 **不会自动注册** Canvas 的 DOM 事件监听器
3. WASM 设计为**被动接收**事件，不主动监听 DOM
4. 必须手动监听 `mousedown`/`mousemove`/`mouseup`/`wheel` 事件
5. 将事件编码成 Protobuf 格式后调用 `ReceiveViewModelCommand`

### 调用流程

```
DOM 事件 → 手动监听器 → Protobuf 编码 → ReceiveViewModelCommand → WASM 处理
```

## 5. 初始化流程

1. 创建 Canvas 元素
2. 设置 `Module.canvas`
3. 监听 `earth-wasm-started` 事件
4. 配置 Module（设置 print, printErr, initArguments）
5. 调用 `ccall("initialize", ...)`
6. 延迟1秒后调用 `ResizeViewport`
7. 注入鼠标事件监听器（延迟1.5秒确保 WASM 完全初始化）

## 6. 关键配置

### Module 对象配置
```javascript
Module.canvas = canvas;              // Canvas 元素
Module.print = null;                 // 禁用打印
Module.printErr = null;              // 禁用错误打印
Module.initArguments = [base64Config]; // 初始化参数
Module['earth-ready'] = true;        // 标记就绪
```

### 关键参数
- `base64Config`: Base64 编码的初始化配置
- `earth-wasm-started`: WASM 启动完成后触发的事件

## 7. 内存管理

### WASM 内存视图
- `Module["HEAP8"]` / `Module["HEAPU8"]` - 8位整数（有符号/无符号）
- `Module["HEAP16"]` / `Module["HEAPU16"]` - 16位整数
- `Module["HEAP32"]` / `Module["HEAPU32"]` - 32位整数
- `Module["HEAPF32"]` - 32位浮点数
- `Module["HEAPF64"]` - 64位浮点数

### 内存分配
```javascript
const ptr = Module._malloc(size);  // 分配内存
// 使用内存...
Module._free(ptr);                  // 释放内存
```

## 8. 注意事项

1. **SharedArrayBuffer**: 需要跨域隔离头部（COOP/COEP）
2. **Canvas 设置**: 必须设置实际的 width/height，不仅仅是 CSS
3. **事件注入时机**: 必须在 WASM 完全初始化后才能注入
4. **Protobuf 编码**: 必须严格按照 wire format 编码
5. **内存管理**: 手动分配的内存必须手动释放

## 9. 初始化参数 Protobuf 分析

### Base64 解码结果

```javascript
const base64Init = 'GgpFbXNjcmlwdGVuKgV6aF9DTjInQUl6YVN5RDhKYTVBSUlpSFZtZ0RBTmhwNXlnT0FrYklpMmhCWjVBWAFgAXgBgAEBkgEJMTAuOTEuMC4xqAEBsgEnQUl6YVN5QUFqWEY4dHRvRWlVMkdZU3dtUkJ2aU8wdHdVODNGa3lB';
const buffer = Buffer.from(base64Init, 'base64');
// Length: 126 bytes
```

### 包含的信息

解析后包含以下字符串：
1. **"Emscripten"** - 标识符
2. **"zh_CN2'AIzaSyD8Ja5AIIiHVmgDANhp5ygOAkbIi2hBZ5AX"** - API Key（地区：中文）
3. **"10.91.0.1"** - 版本号
4. **"'AIzaSyAAjXF8ttoEiU2GYSwmRBviO0twU83FkyA"** - 另一个 API Key

### Protobuf 结构推测

```protobuf
message InitConfig {
  optional string platform = 1;  // "Emscripten"
  optional string api_key = 2;   // Google API Key
  optional string locale = 3;    // "zh_CN"
  optional string version = 4;   // "10.91.0.1"
  optional string config_data = 5; // Base64 或其他配置数据
}
```

## 10. Protobuf Wire Format 详解

### Wire Types

| Type | Number | Name | 说明 |
|------|--------|------|------|
| 0 | Varint | int32, int64, uint32, uint64, sint32, sint64, bool, enum | 变长整数 |
| 1 | 64-bit | fixed64, sfixed64, double | 固定64位 |
| 2 | Length-delimited | string, bytes, embedded messages, packed repeated fields | 长度限定 |
| 3 | Start group | groups (deprecated) | 已废弃 |
| 4 | End group | groups (deprecated) | 已废弃 |
| 5 | 32-bit | fixed32, sfixed32, float | 固定32位 |

### Field Tag 编码

Tag = (field_number << 3) | wire_type

例如：
- `0x12` = 0001 0010 = field 2, wire type 2 (Length-delimited)
- `0x18` = 0001 1000 = field 3, wire type 0 (Varint)
- `0x29` = 0010 1001 = field 5, wire type 1 (64-bit double)

### Varint 编码

Varint 使用 7 位存储数据，最高位作为延续位：
- `0x08` = 8
- `0x01` = 1
- `0x00` = 0
- `0xFF 0x01` = 255

### earth.InputEvent 字段映射（详细）

```protobuf
message InputEvent {
  // field 1: Bool 或标志位 (wire type 0, Varint)
  optional bool field1 = 1;
  
  // field 2: 按钮状态 (wire type 0, Varint)
  // 0 = 无按钮
  // 1 = 左键按下
  // 2 = 右键按下
  // 4 = 释放
  optional int32 button_state = 2;
  
  // field 3: 事件类型 (wire type 0, Varint)
  // 1 = mousedown
  // 2 = mouseup
  // 3 = mousemove
  // 4 = wheel
  optional int32 event_type = 3;
  
  // field 4: 未知标志 (wire type 0, Varint)
  optional int32 field4 = 4;
  
  // field 5: X 坐标 (wire type 1, Double)
  optional double x = 5;
  
  // field 6: Y 坐标 (wire type 1, Double)
  optional double y = 6;
  
  // field 7: Delta X (wheel only, wire type 1, Double)
  optional double delta_x = 7;
  
  // field 8: Delta Y (wheel only, wire type 1, Double)
  optional double delta_y = 8;
  
  // field 10: 未知标志 (wire type 0, Varint)
  optional bool field10 = 10;
}
```

### 事件类型常量

```javascript
const InputEventType = {
  MOUSEDOWN: 1,
  MOUSEUP: 2,
  MOUSEMOVE: 3,
  WHEEL: 4
};

const ButtonState = {
  NONE: 0,
  LEFT: 1,
  MIDDLE: 2,
  RIGHT: 4  // 注意：释放也是 4
};
```

### Protobuf 编码示例详解

#### mousedown 事件编码（26字节 vs 28字节）

根据代码分析，mousedown 有两种编码格式：

**格式1：26字节（不含 field4）**
```
18 18 08 01 10 [btn] 18 01 29 [x64] 31 [y64]
│   │  │  │  │       │     │  │       │
│   │  │  │  │       │     │  │       └─ field 6 (y坐标)
│   │  │  │  │       │     │  └─ field 5 (x坐标，double)
│   │  │  │  │       │     └─ tag=0x29 (field 5, wire type 1)
│   │  │  │  │       └─ value: 1 (mousedown)
│   │  │  │  └─ tag=0x18 (field 3, wire type 0)
│   │  │  └─ value: 1 (field1=true)
│   │  └─ tag=0x08 (field 1, wire type 0)
│   └─ length: 24
└─ tag=0x12 (field 2, wire type 2)
```

**格式2：28字节（含 field4）**
```
18 1A 08 01 10 [btn] 18 01 20 00 29 [x64] 31 [y64]
│   │  │  │  │       │     │  │   │  │       │
│   │  │  │  │       │     │  │   │  │       └─ field 6
│   │  │  │  │       │     │  │   │  └─ field 5
│   │  │  │  │       │     │  │   └─ tag=0x29
│   │  │  │  │       │     │  └─ value: 0 (field4)
│   │  │  │  │       │     └─ tag=0x20 (field 4, wire type 0)
│   │  │  │  │       └─ mousedown
│   │  │  │  └─ button state
│   │  │  └─ field1
│   │  └─ length: 26
└─ tag=0x12
```

#### Wire Type 快速参考

| Wire Type | Hex | Tag 示例 | 说明 |
|-----------|-----|----------|------|
| 0 (Varint) | 0x08, 0x10, 0x18 | 0x18 = field 3 | 1字节，值0-127 |
| 1 (64-bit) | 0x29, 0x31 | 0x29 = field 5 | 8字节固定 |
| 2 (Length) | 0x12, 0x1A | 0x12 = field 2 | 长度字节+数据 |
| 5 (32-bit) | 0x2D | 0x2D = field 5 | 4字节固定 |

#### Field 编号映射

| Field | Type | Tag (Varint) | Tag (Double) | Tag (Length) |
|-------|------|--------------|--------------|--------------|
| 1 | bool | 0x08 | - | - |
| 2 | int32 | 0x10 | - | 0x12 |
| 3 | int32 | 0x18 | - | 0x1A |
| 4 | int32 | 0x20 | - | 0x22 |
| 5 | double | - | 0x29 | 0x2A |
| 6 | double | - | 0x31 | 0x32 |
| 7 | double | - | 0x39 | 0x3A |
| 8 | double | - | 0x41 | 0x42 |
| 10 | bool | 0x50 | - | - |

#### Protobuf 编码工具函数

```javascript
// Varint 编码
function encodeVarint(value) {
  const buffer = [];
  while (value > 0x7F) {
    buffer.push((value & 0x7F) | 0x80);
    value >>>= 7;
  }
  buffer.push(value & 0x7F);
  return Uint8Array.from(buffer);
}

// Double 编码
function encodeDouble(value) {
  const buffer = new ArrayBuffer(8);
  const view = new DataView(buffer);
  view.setFloat64(0, value, true); // little-endian
  return new Uint8Array(buffer);
}

// 创建 Protobuf 消息
function createInputEvent(type, x, y, button = 0, deltaX = 0, deltaY = 0) {
  const parts = [];
  
  // field 1 (bool)
  parts.push(0x08, 0x01);
  
  // field 2 (button state)
  parts.push(0x10, button);
  
  // field 3 (event type)
  parts.push(0x18, type);
  
  // field 5 (x)
  parts.push(0x29);
  parts.push(...encodeDouble(x));
  
  // field 6 (y)
  parts.push(0x31);
  parts.push(...encodeDouble(y));
  
  // 如果是 wheel 事件，添加 delta
  if (type === 4) {
    parts.push(0x39);
    parts.push(...encodeDouble(deltaX));
    parts.push(0x41);
    parts.push(...encodeDouble(deltaY));
    parts.push(0x50, 0x01); // field 10
  }
  
  return Uint8Array.from(parts);
}
```

## 11. 其他消息类型

### 配置文件解析

`wasm/config.base64` 包含多个服务的配置信息：

- `delve_service` - 开发服务
- `earth_document_http_service` - 文档服务
- `earth_gws_service` - GWS 服务
- `fife_service` - FIFE 服务
- `firebase_dynamic_links_service` - Firebase 服务
- `geo_photo_metadata_service` - 照片元数据服务
- `geo_photo_thumbnail_service` - 照片缩略图服务
- `geo_photo_tile_service` - 照片瓦片服务
- `geocoding_service` - 地理编码服务
- `ice_service` - ICE 服务
- `picker_service` - 选择器服务

每个服务配置包含：
- 服务名称
- 端点 URL
- 可选参数

### 推测的配置 Protobuf 结构

```protobuf
message ServiceConfig {
  optional string name = 1;
  optional EndpointConfig endpoint = 2;
}

message EndpointConfig {
  optional string url = 1;
  repeated int32 ports = 2;
}

message EarthConfig {
  repeated ServiceConfig services = 1;
  optional VersionInfo version = 2;
  optional ApiKeys api_keys = 3;
}
```

## 12. 已知问题

1. 鼠标事件必须手动注入，WASM 不会自动处理
2. `Module.canvas` 必须在加载 WASM 之前设置
3. 事件注入代码必须在 `earth-wasm-started` 之后延迟执行
4. Protobuf 编码格式完全依赖逆向工程，没有官方文档
5. 某些字段的语义未知（如 field1, field4, field10）
6. API Key 硬编码在初始化参数中
7. Wire type 3、4、6、7 含义未知（可能已被废弃）
8. Button state = 4 同时表示释放和右键（需要区分）


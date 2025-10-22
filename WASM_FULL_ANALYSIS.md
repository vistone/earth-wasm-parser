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

## 9. 已知问题

1. 鼠标事件必须手动注入，WASM 不会自动处理
2. `Module.canvas` 必须在加载 WASM 之前设置
3. 事件注入代码必须在 `earth-wasm-started` 之后延迟执行
4. Protobuf 编码格式完全依赖逆向工程，没有官方文档


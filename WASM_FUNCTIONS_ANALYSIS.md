# WASM 模块函数完整分析

## 📊 概述

Earth WASM 模块的函数分为几层：
1. **WASM 底层导出** - 编译后的混淆函数名
2. **Emscripten 包装** - ccall/cwrap 机制
3. **JavaScript 接口** - Module 对象的方法
4. **应用层调用** - plugins_compiled.js 中的封装

## 🔍 函数层次结构

### 1. WASM 导出的函数（底层）

从 `earthplugin_web.wasm` 导出 48 个函数（已混淆）：

```
eg, gg, hg, ig, jg, kg, lg, mg, ng, og, pg, qg, rg, sg, tg, ug, vg, wg, xg, yg, zg,
Ag, Bg, Cg, Dg, Eg, Fg, Gg, Hg, Ig, Jg, Kg, Lg, Mg, Ng, Og, Pg, Qg, Rg, Sg, Tg, Ug,
Vg, Wg, Xg, Yg, Zg, _g
```

这些函数通过 Emscripten 的 ccall/cwrap 机制调用。

### 2. Emscripten 机制

#### ccall
动态调用 WASM 函数：
```javascript
Module.ccall("function_name", returnType, argTypes, args)
```

#### cwrap
创建一个包装函数：
```javascript
Module.cwrap("function_name", returnType, argTypes)
```

### 3. JavaScript 接口（Module 对象）

#### 关键函数

##### initialize
初始化 WASM 模块

**调用方式**:
```javascript
Module.ccall("initialize", null, ["string"], [base64Init])
```

**参数**:
- `base64Init`: Base64 编码的初始化配置

**源码位置**: `plugins_compiled.js` → `Zc` 函数

##### ReceiveViewModelCommand
接收视图模型命令（Protobuf 消息）

**调用方式**:
```javascript
window.Module.ReceiveViewModelCommand(messageType, protobufData)
```

**参数**:
- `messageType`: Protobuf 消息类型（如 "earth.InputEvent"）
- `protobufData`: Uint8Array 格式的 Protobuf 编码数据

**源码位置**: `plugins_compiled.js` → `Yc.prototype.Bn`

**示例**:
```javascript
// 发送鼠标事件
const data = encodeMouseDown(x, y);
window.Module.ReceiveViewModelCommand('earth.InputEvent', data);
```

##### ResizeViewport
调整视口大小

**调用方式**:
```javascript
Module.ResizeViewport(width, height)
```

**参数**:
- `width`: 视口宽度
- `height`: 视口高度

**说明**: 在窗口大小改变时调用，更新渲染区域。

##### publish
发布回调函数

**设置方式**:
```javascript
Module.publish = callbackFunction
```

##### onViewportResized
视口大小改变回调

**设置方式**:
```javascript
Module.onViewportResized = function(width, height) { ... }
```

**源码位置**: `plugins_compiled.js` → `Yc.prototype.pn`

##### onShowWtf
显示 WTF 跟踪回调

**设置方式**:
```javascript
Module.onShowWtf = function(data) { ... }
```

**源码位置**: `plugins_compiled.js` → `Yc.prototype.mn`

##### log
日志回调

**设置方式**:
```javascript
Module.log = function(level, message, ...) { ... }
```

**源码位置**: `plugins_compiled.js` → `Yc.prototype.Vm`

### 4. Module 对象属性

#### canvas
Canvas 元素

**设置方式**:
```javascript
Module.canvas = document.getElementById('earth-canvas')
```

#### ctx
Canvas 2D 上下文

**设置方式**:
```javascript
Module.ctx = Module.canvas.getContext('2d')
```

#### print / printErr
输出函数（通常设为 null）

#### initArguments
初始化参数数组

**设置方式**:
```javascript
Module.initArguments = [base64Init]
```

#### earth-ready
初始化完成标志

**设置方式**:
```javascript
Module['earth-ready'] = true
```

## 📝 完整初始化流程

```javascript
// 1. 设置 Module 对象
window.Module = window.Module || {};

// 2. 配置 Module 属性
Module.canvas = document.getElementById('earth-canvas');
Module.print = null;
Module.printErr = null;
Module.initArguments = [base64Init];

// 3. 设置回调函数
Module.publish = publishCallback;
Module.onViewportResized = onViewportResizedCallback;
Module.onShowWtf = onShowWtfCallback;
Module.log = logCallback;

// 4. 标记准备好
Module['earth-ready'] = true;

// 5. 触发初始化事件
window.dispatchEvent(new CustomEvent('earth-ready'));

// 6. 调用初始化函数
Module.ccall("initialize", null, ["string"], [base64Init]);
```

## 🎯 ReceiveViewModelCommand 消息类型

虽然代码中没有直接提取出消息类型列表，但根据之前的分析，以下类型可用：

### earth.InputEvent
鼠标和键盘输入事件

### 其他消息类型
参考 [COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md) 中的 3,789 个消息类型

## 💡 使用建议

### 1. 初始化
```javascript
// 等待 earth-wasm-started 事件
window.addEventListener('earth-wasm-started', () => {
  // 配置 Module
  Module.canvas = canvas;
  Module['earth-ready'] = true;
  
  // 调用初始化
  Module.ccall("initialize", null, ["string"], [base64Init]);
});
```

### 2. 发送鼠标事件
```javascript
function sendMouseEvent(type, x, y, button = 1) {
  const data = encodeInputEvent(type, x, y, button);
  Module.ReceiveViewModelCommand('earth.InputEvent', data);
}
```

### 3. 调整视口
```javascript
window.addEventListener('resize', () => {
  const width = window.innerWidth;
  const height = window.innerHeight;
  Module.ResizeViewport(width, height);
});
```

## 🔗 相关文档

- [WASM_API.md](./WASM_API.md) - WASM API 使用指南
- [PROTO_USAGE_GUIDE.md](./PROTO_USAGE_GUIDE.md) - Protobuf 消息使用指南
- [WASM_FULL_ANALYSIS.md](./WASM_FULL_ANALYSIS.md) - 完整分析文档

## 📊 统计信息

- **WASM 导出函数**: 48 个
- **Module 接口函数**: ~10 个
- **回调函数**: 5 个
- **支持的消息类型**: 3,789 个

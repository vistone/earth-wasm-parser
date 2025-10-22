# WASM 模块 API 文档

本文档记录 Google Earth WASM 模块的所有可用函数和用法。

## 文件结构

```
wasm/
├── earthplugin_web.js      # 主要的 WASM JS 胶水代码 (258KB)
├── earthplugin_web.wasm    # WASM 二进制文件 (20MB)
├── plugins_compiled.js     # 插件编译文件 (248KB)
├── local_file_system_compiled.js  # 本地文件系统 (16KB)
└── config.base64          # Base64 编码的配置文件
```

## Module 对象

所有函数都通过全局 `Module` 对象访问。

### 如何获取 Module 对象

#### 1. 动态加载 WASM 模块后访问

```javascript
// 方式1：从全局 window 对象获取
const Module = window.Module;

// 方式2：从 js.context 获取（Dart 中）
import 'dart:js' as js;
final module = js.context['Module'] as js.JsObject;

// 方式3：确保 JS 文件加载完成后访问
const script = document.createElement('script');
script.src = 'wasm/earthplugin_web.js';
script.onload = () => {
  const Module = window.Module;
  console.log('Module 已加载:', Module);
};
document.head.appendChild(script);
```

#### 2. 监听 earth-wasm-started 事件后访问

```javascript
window.addEventListener('earth-wasm-started', (event) => {
  const Module = window.Module;
  console.log('WASM 已启动，可以使用 Module:', Module);
  
  // 现在可以访问 Module 的所有函数
  const ccall = Module.ccall;
  const initialize = Module._initialize;
});
```

### 如何检查函数是否存在

```javascript
// 检查函数是否存在
if (Module && Module.ResizeViewport) {
  console.log('ResizeViewport 可用');
} else {
  console.log('ResizeViewport 不可用');
}

// 检查函数类型
console.log('ccall 类型:', typeof Module.ccall);
console.log('ccall 是函数?', Module.ccall instanceof Function);
```

### Dart 中如何使用

```dart
import 'dart:js' as js;

// 获取 Module 对象
final module = js.context['Module'] as js.JsObject;

// 调用 ccall
final ccall = module['ccall'];
if (ccall != null && ccall is js.JsFunction) {
  final ret = ccall.apply([
    'initialize',
    null,
    js.JsArray.from(['string']),
    js.JsArray.from([base64Config]),
  ]);
}

// 调用 ResizeViewport
final resize = module['ResizeViewport'];
if (resize != null && resize is js.JsFunction) {
  resize.apply([width, height]);
}
```

### 初始化函数

#### `Module["_initialize"]`
初始化 Earth 模块。

**用法**：
```javascript
// 使用 ccall 调用
Module.ccall('initialize', null, ['string'], [base64Config]);

// 或直接调用（需要先获取函数引用）
Module._initialize(base64Config);
```

**参数**：
- `base64Config` (string): Base64 编码的初始化配置

**返回**：无

#### `Module["_main"]`
主入口函数。

**用法**：
```javascript
Module._main();
```

#### `Module["ResizeViewport"]`
调整视口大小。

**用法**：
```javascript
Module.ResizeViewport(width, height);
```

**参数**：
- `width` (number): 视口宽度
- `height` (number): 视口高度

**示例**：
```javascript
// 调整为 1920x1080
Module.ResizeViewport(1920, 1080);
```

#### `Module["ReceiveViewModelCommand"]`
接收视图模型命令（处理输入事件）。

**用法**：
```javascript
Module.ReceiveViewModelCommand(protobufMessageType, dataArray);
```

**参数**：
- `protobufMessageType` (string): 协议消息类型，如 'earth.InputEvent'
- `dataArray` (Uint8Array): Protobuf 编码的数据

**说明**：此函数用于处理鼠标、键盘等输入事件。WASM 模块会自动注册事件监听器，无需手动调用。

**如何拦截和监听（Dart）**：
```dart
import 'dart:js' as js;

// 获取原始函数
final module = js.context['Module'] as js.JsObject;
final originalReceiveCommand = module['ReceiveViewModelCommand'];

if (originalReceiveCommand != null && originalReceiveCommand is js.JsFunction) {
  // 创建包装函数
  final wrapperFunc = (js.JsFunction originalFunc) {
    return js.allowInterop((String messageType, dynamic data) {
      // 打印事件信息
      print('[鼠标事件] 类型: $messageType');
      
      if (data is js.JsObject) {
        final dataLength = data['length'];
        print('[鼠标事件] 数据长度: $dataLength');
        
        // 提取并打印数据内容
        final list = <int>[];
        final maxBytes = 32;
        final actualBytes = dataLength is int ? dataLength.clamp(0, maxBytes) : maxBytes;
        
        for (int i = 0; i < actualBytes; i++) {
          try {
            final byte = data[i];
            if (byte is int) {
              list.add(byte);
            }
          } catch (e) {
            break;
          }
        }
        
        print('[鼠标事件] 数据内容 (十六进制): ${list.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ')}');
        print('[鼠标事件] 数据内容 (十进制): $list');
      }
      
      // 调用原始函数
      return originalFunc.apply([messageType, data]);
    });
  }(originalReceiveCommand);
  
  // 替换原始函数
  module['ReceiveViewModelCommand'] = wrapperFunc;
}
```

**JavaScript 中如何拦截**：
```javascript
// 保存原始函数
const originalReceiveCommand = Module.ReceiveViewModelCommand;

// 创建包装函数
Module.ReceiveViewModelCommand = function(messageType, data) {
  console.log('[鼠标事件] 类型:', messageType);
  console.log('[鼠标事件] 数据长度:', data.length);
  console.log('[鼠标事件] 数据内容:', Array.from(data.slice(0, 32)));
  
  // 调用原始函数
  return originalReceiveCommand.call(this, messageType, data);
};
```

---

### 内存管理函数

#### `Module["_malloc"]`
分配内存。

**用法**：
```javascript
const ptr = Module._malloc(size);
```

**参数**：
- `size` (number): 要分配的字节数

**返回**：内存指针（number）

#### `Module["_free"]`
释放内存。

**用法**：
```javascript
Module._free(ptr);
```

**参数**：
- `ptr` (number): 要释放的内存指针

#### `Module["_malloc"]` / `Module["_free"]`
使用 Emscripten 标准内存管理。

**示例**：
```javascript
// 分配 1024 字节
const ptr = Module._malloc(1024);

// 使用内存...

// 释放内存
Module._free(ptr);
```

---

### 函数调用包装器

#### `Module["ccall"]`
调用 C 函数。

**用法**：
```javascript
const result = Module.ccall(functionName, returnType, argTypes, args);
```

**参数**：
- `functionName` (string): 函数名
- `returnType` (string|null): 返回类型 ('number', 'string', null等)
- `argTypes` (array): 参数类型数组
- `args` (array): 参数值数组

**示例**：
```javascript
// 调用 initialize 函数
const ret = Module.ccall('initialize', null, ['string'], [base64Config]);
```

#### `Module["cwrap"]`
包装 C 函数为 JavaScript 函数。

**用法**：
```javascript
const wrappedFunc = Module.cwrap(functionName, returnType, argTypes);
```

**参数**：
- `functionName` (string): 函数名
- `returnType` (string): 返回类型
- `argTypes` (array): 参数类型数组

**返回**：JavaScript 函数

**示例**：
```javascript
// 包装 malloc 函数
const malloc = Module.cwrap('malloc', 'number', ['number']);
const ptr = malloc(1024);
```

---

### Canvas 和 WebGL 相关

#### `Module["canvas"]`
Canvas 元素引用。

**设置**：
```javascript
Module.canvas = canvasElement;
```

**使用**：
```javascript
const canvas = Module.canvas;
```

#### `Module["ctx"]`
WebGL 上下文。

**访问**：
```javascript
const gl = Module.ctx;
```

#### `Module["GL"]`
WebGL 对象。

**属性**：
- `Module.GL.textures` - 纹理对象数组
- `Module.GL.programs` - 着色器程序数组
- `Module.GL.currentContext` - 当前 WebGL 上下文

---

### 事件和生命周期

#### `Module["preRun"]`
预运行回调。

**设置**：
```javascript
Module.preRun = function() {
  console.log('即将运行');
};
```

#### `Module["postRun"]`
运行后回调。

**设置**：
```javascript
Module.postRun = function() {
  console.log('运行完成');
};
```

#### `Module["onRuntimeInitialized"]`
运行时初始化完成回调。

**设置**：
```javascript
Module.onRuntimeInitialized = function() {
  console.log('WASM 运行时已初始化');
};
```

---

### 文件系统函数

#### `Module["FS_createPath"]`
创建目录路径。

**用法**：
```javascript
Module.FS_createPath(parent, name, canRead, canWrite);
```

#### `Module["FS_createDataFile"]`
创建数据文件。

**用法**：
```javascript
Module.FS_createDataFile(path, name, data, canRead, canWrite);
```

#### `Module["FS_createLazyFile"]`
创建懒加载文件。

**用法**：
```javascript
Module.FS_createLazyFile(path, name, url, canRead, canWrite);
```

#### `Module["FS_unlink"]`
删除文件。

**用法**：
```javascript
Module.FS_unlink(path);
```

#### `Module["FS_preloadFile"]`
预加载文件。

**用法**：
```javascript
Module.FS_preloadFile(path, url);
```

---

### 本地文件系统 API (local_file_system_compiled.js)

#### `Module["LocalFileSystem_InitAgentSuccess"]`
文件系统初始化成功回调。

#### `Module["LocalFileSystem_InitAgentError"]`
文件系统初始化错误回调。

#### `Module["LocalFileSystem_ReadFileSuccess"]`
读取文件成功回调。

#### `Module["LocalFileSystem_ReadFileError"]`
读取文件错误回调。

#### `Module["LocalFileSystem_AddFileSuccess"]`
添加文件成功回调。

#### `Module["LocalFileSystem_ModifyFileSuccess"]`
修改文件成功回调。

#### `Module["LocalFileSystem_RemoveFileSuccess"]`
删除文件成功回调。

#### `Module["LocalFileSystem_ListFilesSuccess"]`
列出文件成功回调。

---

### 插件函数 (plugins_compiled.js)

#### `Module["labelRenderer"]`
标签渲染器对象。

**方法**：
- `renderAsync(requestid, string, pointSize, bold, italic, leadingRatio, tracking, outlineWidth)` - 异步渲染标签
- `canvasSubImage(texid, level, xoffset, yoffset, canvasid)` - 上传 Canvas 子图像
- `deleteCanvasSubImage(canvasid)` - 删除 Canvas 子图像

---

### 字符串转换函数

#### `Module["UTF8ToString"]`
将 UTF8 编码的指针转换为字符串。

**用法**：
```javascript
const str = Module.UTF8ToString(ptr);
```

#### `Module["stringToUTF8"]`
将字符串转换为 UTF8 编码。

**用法**：
```javascript
const ptr = Module.stringToUTF8(str, buffer, maxBytes);
```

---

### WASM 内存视图

#### `Module["HEAP8"]` / `Module["HEAPU8"]`
8 位整数堆视图（signed/unsigned）。

#### `Module["HEAP16"]` / `Module["HEAPU16"]`
16 位整数堆视图（signed/unsigned）。

#### `Module["HEAP32"]` / `Module["HEAPU32"]`
32 位整数堆视图（signed/unsigned）。

#### `Module["HEAPF32"]`
32 位浮点数堆视图。

#### `Module["HEAPF64"]`
64 位浮点数堆视图。

**示例**：
```javascript
// 读取 32 位整数
const value = Module.HEAP32[ptr >> 2];

// 写入 32 位浮点数
Module.HEAPF32[ptr >> 2] = 3.14;
```

---

### 生命周期和状态

#### `Module["calledRun"]`
指示 run() 是否已被调用。

#### `Module["noInitialRun"]`
设置为 true 时跳过自动运行。

#### `Module["setStatus"]`
设置状态文本。

**用法**：
```javascript
Module.setStatus = function(text) {
  console.log(text);
};
```

---

### 事件触发

#### `window.dispatchEvent(new Event('earth-wasm-started'))`
WASM 模块启动完成事件。

**监听**：
```javascript
window.addEventListener('earth-wasm-started', (event) => {
  console.log('WASM 模块已启动');
});
```

---

## 配置对象

### Module 对象配置属性

```javascript
Module = {
  canvas: HTMLCanvasElement,          // Canvas 元素
  print: Function|null,              // 标准输出回调
  printErr: Function|null,           // 错误输出回调
  initArguments: Array,               // 初始化参数数组
  'earth-ready': boolean,            // Earth 就绪标志
  ctx: WebGLRenderingContext,        // WebGL 上下文
};
```

**完整配置示例**：
```javascript
Module.canvas = document.getElementById('earth-canvas');
Module.print = null;
Module.printErr = null;
Module.initArguments = [base64Config];
Module['earth-ready'] = true;
```

---

## 使用流程

### 1. 加载 WASM 模块

```javascript
// 动态加载 JS 文件
const script = document.createElement('script');
script.src = 'wasm/earthplugin_web.js';
document.head.appendChild(script);
```

### 2. 配置 Module 对象

```javascript
window.addEventListener('earth-wasm-started', (event) => {
  const module = window.Module;
  
  // 配置 Canvas
  module.canvas = document.getElementById('earth-canvas');
  
  // 设置初始化参数
  module.initArguments = [base64Config];
  module['earth-ready'] = true;
  
  // 调用初始化
  module.ccall('initialize', null, ['string'], [base64Config]);
});
```

### 3. 调整视口大小

```javascript
const width = window.innerWidth;
const height = window.innerHeight;
Module.ResizeViewport(width, height);
```

### 4. 监听窗口大小变化

```javascript
window.addEventListener('resize', () => {
  const width = window.innerWidth;
  const height = window.innerHeight;
  Module.ResizeViewport(width, height);
});
```

---

## 完整使用示例

### Dart/Flutter 完整示例

```dart
import 'dart:html' as html;
import 'dart:js' as js;

class EarthViewer {
  static const String base64Config = 'GgpFbXNjcmlwdGVuKgV6aF9DTjInQUl6YVN5RDhKYTVBSUlpSFZtZ0RBTmhwNXlnT0FrYklpMmhCWjVBWAFgAXgBgAEBkgEJMTAuOTEuMC4xqAEBsgEnQUl6YVN5QUFqWEY4dHRvRWlVMkdZU3dtUkJ2aU8wdHdVODNGa3lB';
  
  // 1. 监听 earth-wasm-started 事件
  void setupModuleListener() {
    html.window.addEventListener('earth-wasm-started', (event) {
      final module = js.context['Module'] as js.JsObject;
      
      // 2. 获取并调用 ccall
      final ccall = module['ccall'];
      if (ccall != null && ccall is js.JsFunction) {
        ccall.apply([
          'initialize',
          null,
          js.JsArray.from(['string']),
          js.JsArray.from([base64Config]),
        ]);
      }
      
      // 3. 获取并调用 ResizeViewport
      Future.delayed(const Duration(seconds: 1), () {
        final resize = module['ResizeViewport'];
        if (resize != null && resize is js.JsFunction) {
          final width = html.window.innerWidth ?? 1920;
          final height = html.window.innerHeight ?? 1080;
          resize.apply([width, height]);
        }
      });
      
      // 4. 拦截 ReceiveViewModelCommand
      final originalReceiveCommand = module['ReceiveViewModelCommand'];
      if (originalReceiveCommand != null && originalReceiveCommand is js.JsFunction) {
        final wrapperFunc = js.allowInterop((String messageType, dynamic data) {
          print('[事件] 类型: $messageType, 数据长度: ${data['length']}');
          return originalReceiveCommand.apply([messageType, data]);
        });
        module['ReceiveViewModelCommand'] = wrapperFunc;
      }
    });
  }
  
  // 5. 加载 WASM 模块
  void loadWasmModule() {
    final script = html.ScriptElement()
      ..src = 'wasm/earthplugin_web.js'
      ..type = 'text/javascript';
    
    script.onLoad.listen((_) {
      print('WASM JS 文件加载成功');
    });
    
    html.document.head?.append(script);
  }
}
```

### JavaScript 完整示例

```javascript
// 1. 加载 WASM 模块
const script = document.createElement('script');
script.src = 'wasm/earthplugin_web.js';
script.onload = () => {
  console.log('WASM JS 文件加载成功');
};
document.head.appendChild(script);

// 2. 监听 earth-wasm-started 事件
window.addEventListener('earth-wasm-started', (event) => {
  const Module = window.Module;
  
  // 3. 调用初始化
  const base64Config = 'GgpFbXNjcmlwdGVuKgV6aF9DTjInQUl6YVN5RDhKYTVBSUlpSFZtZ0RBTmhwNXlnT0FrYklpMmhCWjVBWAFgAXgBgAEBkgEJMTAuOTEuMC4xqAEBsgEnQUl6YVN5QUFqWEY4dHRvRWlVMkdZU3dtUkJ2aU8wdHdVODNGa3lB';
  Module.ccall('initialize', null, ['string'], [base64Config]);
  
  // 4. 调整视口大小
  setTimeout(() => {
    Module.ResizeViewport(window.innerWidth, window.innerHeight);
  }, 1000);
  
  // 5. 拦截 ReceiveViewModelCommand
  const originalReceiveCommand = Module.ReceiveViewModelCommand;
  Module.ReceiveViewModelCommand = function(messageType, data) {
    console.log('[事件] 类型:', messageType);
    console.log('[事件] 数据长度:', data.length);
    console.log('[事件] 数据内容:', Array.from(data.slice(0, 32)));
    return originalReceiveCommand.call(this, messageType, data);
  };
});

// 6. 监听窗口大小变化
window.addEventListener('resize', () => {
  if (window.Module && window.Module.ResizeViewport) {
    window.Module.ResizeViewport(window.innerWidth, window.innerHeight);
  }
});
```

### 如何调试和查看所有可用函数

```javascript
// 列出 Module 对象的所有属性
function listModuleFunctions() {
  const Module = window.Module;
  console.log('=== Module 对象的所有属性 ===');
  
  for (const key in Module) {
    const value = Module[key];
    const type = typeof value;
    console.log(`${key}: ${type}`);
    
    if (type === 'function') {
      console.log(`  -> 函数: ${key}`);
    }
  }
}

// 监听后调用
window.addEventListener('earth-wasm-started', () => {
  listModuleFunctions();
});
```

### 如何检查特定函数是否存在

```javascript
function checkFunctionExists(functionName) {
  const Module = window.Module;
  
  if (!Module) {
    console.log(`${functionName}: Module 对象不存在`);
    return false;
  }
  
  if (!Module[functionName]) {
    console.log(`${functionName}: 函数不存在`);
    return false;
  }
  
  if (typeof Module[functionName] !== 'function') {
    console.log(`${functionName}: 不是函数 (类型: ${typeof Module[functionName]})`);
    return false;
  }
  
  console.log(`${functionName}: ✓ 可用`);
  return true;
}

// 使用示例
checkFunctionExists('ccall');
checkFunctionExists('cwrap');
checkFunctionExists('ResizeViewport');
checkFunctionExists('ReceiveViewModelCommand');
checkFunctionExists('_initialize');
checkFunctionExists('_malloc');
checkFunctionExists('_free');
```

---

## 注意事项

1. **SharedArrayBuffer**：需要跨域隔离头部
   - `Cross-Origin-Opener-Policy: same-origin`
   - `Cross-Origin-Embedder-Policy: require-corp`

2. **鼠标事件**：WASM 模块会自动注册和处理，无需手动注入

3. **Canvas 尺寸**：必须设置实际的 width 和 height 属性，不仅仅 CSS 大小

4. **内存管理**：使用 malloc/free 管理的指针需要手动释放

5. **事件监听**：必须在 'earth-wasm-started' 事件后配置 Module

---

## 参考

- Emscripten 文档：https://emscripten.org/docs/api_reference/
- Google Earth API 文档
- Protobuf 消息格式：earth.InputEvent


# EarthPlugin Web 完整分析报告

## 📊 文件概览

### 文件结构

```
wasm/
├── earthplugin_web.wasm        # 19.06 MB - WASM 二进制文件
├── earthplugin_web.js          # 257.57 KB - Emscripten 生成的 JS 胶水代码
├── plugins_compiled.js          # 247.80 KB - 插件和初始化代码
├── local_file_system_compiled.js # 15.78 KB - 本地文件系统支持
└── config.base64                # 1.76 KB - Base64 编码的配置数据
```

### 文件大小统计

| 文件 | 大小 | 占比 |
|------|------|------|
| earthplugin_web.wasm | 19.06 MB | 96.6% |
| earthplugin_web.js | 257.57 KB | 1.3% |
| plugins_compiled.js | 247.80 KB | 1.3% |
| local_file_system_compiled.js | 15.78 KB | 0.1% |
| config.base64 | 1.76 KB | 0.0% |
| **总计** | **~20 MB** | **100%** |

## 🔍 详细分析

### 1. earthplugin_web.wasm

**描述**: WebAssembly 二进制文件，包含所有核心逻辑

**关键信息**:
- **大小**: 19,982,569 bytes
- **魔数**: `0061736d` (WASM 标准)
- **导出函数**: 48 个（已混淆）
- **Protobuf 消息**: 3,789 个
- **命名空间**: 455 个

**主要内容**:
- Earth 引擎核心逻辑
- 3D 渲染引擎
- Protobuf 消息处理
- 相机和输入控制
- 地理数据处理

**函数映射** (详见 [WASM_OBFUSCATED_FUNCTIONS.md](./WASM_OBFUSCATED_FUNCTIONS.md)):
- `hg` → `_main` - 主函数
- `ig` → `_initialize` - 初始化
- `jg` → `_malloc` - 内存分配
- `kg` → `_free` - 内存释放
- ... 共 48 个函数

### 2. earthplugin_web.js

**描述**: Emscripten 生成的 JavaScript 胶水代码

**关键信息**:
- **大小**: 263,747 字符
- **Module 引用**: 155 次
- **函数定义**: 304 个
- **Module 导出**: 56 个

**核心功能**:
```javascript
Module.exports = {
  preRun, postRun,           // 运行时钩子
  ccall, cwrap,             // C 函数调用
  _main, _initialize,       // 核心函数
  _malloc, _free,          // 内存管理
  GL,                       // WebGL 上下文
  FS_*,                     // 文件系统操作
  // ... 更多导出
}
```

**关键函数**:
- `createWasm()` - 创建 WASM 实例
- `assignWasmExports()` - 分配 WASM 导出
- `callMain()` - 调用主函数
- `initRuntime()` - 初始化运行时
- WebGL 相关函数（300+ 个）

### 3. plugins_compiled.js

**描述**: 插件和初始化逻辑，包含 `ReceiveViewModelCommand` 实现

**关键信息**:
- **大小**: 253,745 字符
- **Yc.prototype**: 7 个方法
- **ReceiveViewModelCommand**: 1 次调用
- **Module 引用**: 4 次

**关键类**: `Yc.prototype`
```javascript
Yc.prototype.initialize = function(a, b) {
  // 初始化 WASM 模块
  window.earthWasmStarted ? Zc(this, a, b) : 
    window.addEventListener("earth-wasm-started", function() {
      Zc(c, a, b)
    })
};

Yc.prototype.Bn = function(a, b) {
  // 发布视图模型命令
  var c = window.Module;
  (c = c ? c.ReceiveViewModelCommand : null) && c(a, b)
};

Yc.prototype.pn = function(a, b) {
  // 视口大小改变回调
  var c = window.devicePixelRatio,
      d = window.Module;
  if (d = d ? d.canvas : null)
    a = Math.ceil(a / c),
    b = Math.ceil(b / c),
    d.style.width = a + "px",
    d.style.height = b + "px",
    d.width = a * c,
    d.height = b * c
};
```

**初始化流程**:
1. 等待 `earth-wasm-started` 事件
2. 配置 Module 对象
3. 设置回调函数
4. 调用 `ccall("initialize")`

### 4. local_file_system_compiled.js

**描述**: 本地文件系统支持代码

**关键信息**:
- **大小**: 16,155 字符
- **函数定义**: 9 个

**主要功能**:
- 文件系统操作
- IndexedDB 集成
- 异步文件读写

### 5. config.base64

**描述**: Base64 编码的 Protobuf 配置数据

**关键信息**:
- **Base64 长度**: 1,807 字符
- **解码后大小**: 1,355 bytes
- **数据类型**: Protobuf (字段标签 `0x0a`)

**用途**: 初始化配置，包含 Earth 引擎的默认设置

## 🔗 文件间关系

### 加载顺序

```
1. earthplugin_web.js 加载
   ├─ 初始化 Module 对象
   ├─ 创建 WASM 实例
   └─ 触发 'earth-wasm-started' 事件

2. plugins_compiled.js 执行
   ├─ 监听 'earth-wasm-started' 事件
   ├─ 配置 Module 对象
   ├─ 设置回调函数
   └─ 调用 ccall("initialize", ...)

3. 运行时
   ├─ ReceiveViewModelCommand() 接收 Protobuf 消息
   ├─ 处理各种事件
   └─ 渲染地球
```

### 调用关系

```
JavaScript 代码
    ↓
Module.ccall("initialize")
    ↓
WASM: _initialize (ig)
    ↓
初始化完成 → Module['earth-ready'] = true
    ↓
可以使用 ReceiveViewModelCommand
```

## 📚 相关文档

- [WASM_OBFUSCATED_FUNCTIONS.md](./WASM_OBFUSCATED_FUNCTIONS.md) - 函数映射
- [COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md) - 所有 Protobuf 消息
- [WASM_FUNCTIONS_ANALYSIS.md](./WASM_FUNCTIONS_ANALYSIS.md) - 函数使用分析
- [PROTO_USAGE_GUIDE.md](./PROTO_USAGE_GUIDE.md) - Protobuf 使用指南
- [PBTK_EXTRACTION_SUMMARY.md](./PBTK_EXTRACTION_SUMMARY.md) - pbtk 提取总结

## 🎯 关键发现

### 1. WASM 模块结构
- 编译产物约为 20MB
- 导出 48 个函数（已混淆）
- 包含 3,789 个 Protobuf 消息类型

### 2. JavaScript 桥接
- Emscripten 生成胶水代码
- Module 对象为 JS-WASM 桥接
- ccall/cwrap 用于函数调用

### 3. 初始化流程
- 等待事件触发
- 配置 Module 对象
- 调用初始化函数
- 设置回调

### 4. 消息传递
- 使用 Protobuf 编码
- ReceiveViewModelCommand 接收消息
- earth.InputEvent 处理输入

### 5. 文件系统
- IndexedDB 持久化
- 异步文件操作
- 支持本地存储

## 💡 使用建议

### 初始化

```javascript
// 1. 等待 WASM 加载
window.addEventListener('earth-wasm-started', () => {
  // 2. 配置 Module
  Module.canvas = document.getElementById('earth-canvas');
  Module.initArguments = [base64Init];
  
  // 3. 调用初始化
  Module.ccall("initialize", null, ["string"], [base64Init]);
});
```

### 发送消息

```javascript
// 发送鼠标事件
const data = encodeMouseDown(x, y);
Module.ReceiveViewModelCommand('earth.InputEvent', data);
```

### 调整视口

```javascript
window.addEventListener('resize', () => {
  Module.ResizeViewport(width, height);
});
```

## 📝 总结

EarthPlugin Web 是一个完整的 WebAssembly 地球引擎，包含：

1. **WASM 核心** - 20MB 的编译代码
2. **JS 桥接** - Emscripten 胶水代码
3. **初始化逻辑** - 插件和配置
4. **文件系统** - 本地存储支持
5. **配置数据** - Protobuf 编码

所有组件协同工作，实现了一个功能完整的地球可视化系统。


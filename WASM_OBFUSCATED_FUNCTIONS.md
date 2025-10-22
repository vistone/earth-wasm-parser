# WASM 混淆函数映射表

通过分析 JavaScript 代码的流程，成功破解了混淆函数名的真实含义。

## 🔍 函数映射关系

从 `assignWasmExports` 函数中提取的完整映射：

| 混淆名 | 真实函数名 | 用途 |
|--------|-----------|------|
| `gg` | `_pthread_self` | 获取当前线程 ID |
| `hg` | `_main` | **主函数入口** |
| `ig` | `_initialize` | **初始化函数** |
| `jg` | `_malloc` | 内存分配 |
| `kg` | `_free` | 内存释放 |
| `lg` | `___getTypeName` | 获取类型名称 |
| `mg` | `__embind_initialize_bindings` | Embind 绑定初始化 |
| `ng` | `__emscripten_tls_init` | TLS（线程本地存储）初始化 |
| `og` | `_emscripten_builtin_memalign` | 内存对齐分配 |
| `pg` | `__emscripten_run_callback_on_thread` | 在线程上运行回调 |
| `qg` | `__emscripten_thread_init` | 线程初始化 |
| `rg` | `__emscripten_thread_crashed` | 线程崩溃处理 |
| `sg` | `__emscripten_run_js_on_main_thread` | 在主线程运行 JS |
| `tg` | `__emscripten_thread_free_data` | 释放线程数据 |
| `ug` | `__emscripten_thread_exit` | 线程退出 |
| `vg` | `__emscripten_check_mailbox` | 检查邮箱（线程通信） |
| `wg` | `_setThrew` | 设置异常状态 |
| `xg` | `__emscripten_tempret_set` | 设置临时返回值 |
| `yg` | `_emscripten_stack_set_limits` | 设置栈限制 |
| `zg` | `__emscripten_stack_restore` | 恢复栈 |
| `Ag` | `__emscripten_stack_alloc` | 分配栈空间 |
| `Bg` | `_emscripten_stack_get_current` | 获取当前栈 |

## 🔄 dynCall 系列函数

动态调用函数（用于函数指针调用）：

| 混淆名 | 真实函数名 | 签名 |
|--------|-----------|------|
| `Cg` | `dynCall_iiiijij` | (int, int, int, int, js, int, js) -> int |
| `Dg` | `dynCall_ji` | (js) -> int |
| `Eg` | `dynCall_vij` | (void, int, js) -> void |
| `Fg` | `dynCall_iij` | (int, int, js) -> int |
| `Gg` | `dynCall_viiiijii` | (void, int, int, int, int, js, int, int) -> void |
| `Hg` | `dynCall_jii` | (js, int, int) -> js |
| `Ig` | `dynCall_viij` | (void, int, int, js) -> void |
| `Jg` | `dynCall_jijj` | (js, int, js, js) -> js |
| `Kg` | `dynCall_jiiiiii` | (js, int, int, int, int, int, int) -> js |
| `Lg` | `dynCall_jiiiii` | (js, int, int, int, int, int) -> js |
| `Mg` | `dynCall_iiji` | (int, int, js, int) -> int |
| `Ng` | `dynCall_iiij` | (int, int, int, js) -> int |
| `Og` | `dynCall_iijjii` | (int, int, js, js, int, int) -> int |
| `Pg` | `dynCall_viiiji` | (void, int, int, int, js, int) -> void |
| `Qg` | `dynCall_iiiji` | (int, int, int, js, int) -> int |
| `Rg` | `dynCall_vijj` | (void, int, js, js) -> void |
| `Sg` | `dynCall_vijjj` | (void, int, js, js, js) -> void |
| `Tg` | `dynCall_viji` | (void, int, js, int) -> void |
| `Ug` | `dynCall_viijii` | (void, int, int, js, int, int) -> void |
| `Vg` | `dynCall_vj` | (void, js) -> void |
| `Wg` | `dynCall_iijjiiii` | (int, int, js, js, int, int, int, int) -> int |
| `Xg` | `dynCall_jiji` | (js, int, js, int) -> js |
| `Yg` | `dynCall_iiiiij` | (int, int, int, int, int, js) -> int |
| `Zg` | `dynCall_iiiiijj` | (int, int, int, int, int, js, js) -> int |
| `_g` | `dynCall_iiiiiijj` | (int, int, int, int, int, int, js, js) -> int |

## 🎯 关键函数分析

### _main (hg)
主函数入口，由 `callMain` 调用。

**调用方式**:
```javascript
var entryFunction = _main;
var ret = entryFunction(argc, argv);
```

### _initialize (ig)
初始化函数，通过 ccall 调用。

**调用方式**:
```javascript
Module.ccall("initialize", null, ["string"], [base64Init])
```

### _malloc / _free (jg / kg)
内存管理函数。

**调用方式**:
```javascript
var ptr = Module._malloc(size);
Module._free(ptr);
```

### dynCall 系列
用于动态调用函数指针，实现回调机制。

## 📊 函数分类

### 内存管理
- `_malloc` (jg) - 分配内存
- `_free` (kg) - 释放内存
- `_emscripten_builtin_memalign` (og) - 对齐分配

### 线程管理
- `_pthread_self` (gg) - 获取线程 ID
- `__emscripten_thread_init` (qg) - 初始化线程
- `__emscripten_thread_exit` (ug) - 退出线程
- `__emscripten_thread_crashed` (rg) - 线程崩溃处理
- `__emscripten_check_mailbox` (vg) - 检查线程邮箱

### 栈管理
- `__emscripten_stack_alloc` (Ag) - 分配栈
- `__emscripten_stack_restore` (zg) - 恢复栈
- `_emscripten_stack_get_current` (Bg) - 获取当前栈
- `_emscripten_stack_set_limits` (yg) - 设置栈限制

### Embind（C++ 绑定）
- `__embind_initialize_bindings` (mg) - 初始化绑定
- `___getTypeName` (lg) - 获取类型名

### 核心函数
- `_main` (hg) - 主函数
- `_initialize` (ig) - 初始化
- `_setThrew` (wg) - 异常处理

## 💡 发现流程

1. **查找函数赋值** - 搜索 `assignWasmExports` 函数
2. **提取映射关系** - 解析 `wasmExports["xx"]` 分配
3. **分析函数名** - 通过函数名推测用途
4. **验证调用** - 在代码中查找使用位置

## 🔗 相关文档

- [WASM_FUNCTIONS_ANALYSIS.md](./WASM_FUNCTIONS_ANALYSIS.md) - 函数使用分析
- [WASM_FULL_ANALYSIS.md](./WASM_FULL_ANALYSIS.md) - 完整分析
- [WASM_API.md](./WASM_API.md) - API 文档

## 📝 总结

通过逆向分析 JavaScript 代码流程，成功破解了 48 个混淆函数名的真实含义，包括：
- 核心函数（main, initialize）
- 内存管理函数
- 线程管理函数
- 栈管理函数
- Embind 绑定函数
- 动态调用函数

这些信息为深入理解 WASM 模块的内部机制提供了重要线索。


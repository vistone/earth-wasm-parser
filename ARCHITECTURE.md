# WASM Parser 架构文档

## 系统架构概述

本项目采用**分层架构**设计，实现了 Dart/Flutter 与 WebAssembly 的无缝集成。

```
┌─────────────────────────────────────────────┐
│           UI Layer (Presentation)            │
│         main.dart - Flutter Widgets          │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│        Service Layer (Business Logic)        │
│    earth_plugin_service.dart - 业务封装      │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│       Core Layer (WASM Integration)          │
│      wasm_loader.dart - WASM 加载器          │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│     JavaScript Interop (dart:js_interop)     │
│              dart:html - DOM API             │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│         JavaScript Layer (Glue Code)         │
│          earthplugin_web.js (Emscripten)     │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│           WebAssembly Module                 │
│          earthplugin_web.wasm                │
└─────────────────────────────────────────────┘
```

## 核心组件详解

### 1. WasmLoader (核心层)

**职责**: 
- 动态加载 WASM 模块和 JS 胶水代码
- 提供底层 WASM 函数调用接口
- 管理 WASM 内存（malloc/free）
- 封装 Emscripten API（ccall/cwrap）

**关键方法**:
```dart
class WasmLoader {
  Future<void> loadModule()               // 加载模块
  dynamic callFunction(String, List)      // 调用函数
  dynamic ccall(...)                      // C 函数调用
  Function? cwrap(...)                    // 函数包装
  int malloc(int size)                    // 分配内存
  void free(int ptr)                      // 释放内存
  WasmModuleInfo getModuleInfo()          // 获取信息
}
```

**设计模式**:
- **Singleton**: 确保只有一个 WASM 实例
- **Facade**: 隐藏 JavaScript 互操作的复杂性
- **Factory**: 动态创建和初始化 WASM 模块

### 2. EarthPluginService (服务层)

**职责**:
- 提供高级业务 API
- 封装具体的 WASM 功能
- 处理业务逻辑和数据转换
- 统一错误处理

**设计原则**:
- **单一职责**: 每个方法只做一件事
- **依赖注入**: 通过构造函数注入 WasmLoader
- **面向接口**: 易于测试和扩展

**示例方法**:
```dart
class EarthPluginService {
  Future<bool> initialize()                          // 初始化
  CoordinateResult? convertCoordinate(lat, lon)      // 坐标转换
  String? processString(String input)                // 字符串处理
  List<double>? batchProcess(List<double>)           // 批量处理
  PluginVersion? getVersion()                        // 获取版本
  PluginStats getStats()                             // 统计信息
  void dispose()                                     // 资源清理
}
```

### 3. UI Layer (展示层)

**职责**:
- 用户交互界面
- 状态管理
- 数据展示

**组件结构**:
```dart
WasmParserApp (StatelessWidget)
  └─ MaterialApp
      └─ WasmParserHomePage (StatefulWidget)
          └─ _WasmParserHomePageState
              ├─ _buildStatusCard()      // 状态显示
              ├─ _buildInputCard()       // 输入区域
              ├─ _buildActionButtons()   // 操作按钮
              └─ _buildOutputCard()      // 输出显示
```

## 数据流

### 加载流程

```
1. 用户触发加载
   └─> _loadWasm()
       └─> WasmLoader.loadModule()
           ├─> 创建 <script> 标签
           ├─> 加载 earthplugin_web.js
           ├─> 获取全局 Module 对象
           ├─> 等待 Module 初始化
           └─> 标记为已加载

2. UI 更新
   └─> setState() 更新状态显示
```

### 函数调用流程

```
1. 用户输入参数
   └─> _callWasmFunction()
       └─> WasmLoader.callFunction()
           ├─> 检查模块是否加载
           ├─> 查找函数引用
           ├─> 转换参数为 JS 类型
           ├─> 调用函数
           └─> 返回结果

2. 结果处理
   └─> setState() 更新输出显示
```

## JavaScript 互操作

### Dart 到 JavaScript 类型映射

| Dart Type | JavaScript Type | 转换方法 |
|-----------|----------------|----------|
| int       | Number         | `.toJS` |
| double    | Number         | `.toJS` |
| String    | String         | `.toJS` |
| bool      | Boolean        | `.toJS` |
| List      | Array          | `.map().toJS` |
| Map       | Object         | 手动转换 |

### JavaScript 到 Dart 类型映射

| JavaScript Type | Dart Type | 转换方法 |
|----------------|-----------|----------|
| Number         | int/double | `as int` / `as double` |
| String         | String    | `as String` |
| Boolean        | bool      | `as bool` |
| Array          | List      | 手动转换 |
| Object         | Map       | 手动转换 |

## Emscripten API 说明

### ccall - C 函数调用

```dart
// 语法
ccall(functionName, returnType, argTypes, args)

// 示例
final result = loader.ccall(
  'calculate',       // C 函数名
  'number',          // 返回类型
  ['number', 'number'], // 参数类型数组
  [10, 20]          // 参数值数组
);
```

**支持的类型**:
- `'number'`: 数字（int/double）
- `'string'`: 字符串
- `'array'`: 数组
- `null`: 无返回值

### cwrap - 函数包装器

```dart
// 创建包装函数
final addFunc = loader.cwrap(
  'add',
  'number',
  ['number', 'number']
);

// 多次调用（性能更好）
final result1 = addFunc(10, 20);
final result2 = addFunc(30, 40);
```

**性能优势**:
- 避免每次调用时的函数查找
- 减少类型转换开销
- 适合频繁调用的场景

### 内存管理

```dart
// 分配内存
final ptr = loader.malloc(1024);

// 写入数据（需要使用 Module 的 HEAP* 数组）
// Module.HEAP32[ptr >> 2] = value;

// 调用函数处理数据
loader.callFunction('process', [ptr, length]);

// 读取结果
// final result = Module.HEAP32[ptr >> 2];

// 释放内存
loader.free(ptr);
```

## 错误处理策略

### 1. 分层错误处理

```dart
// UI 层：用户友好的错误消息
try {
  _callWasmFunction();
} catch (e) {
  setState(() {
    _output = '操作失败，请重试';
  });
}

// Service 层：业务错误处理
try {
  final result = processData(input);
  return result;
} catch (e) {
  print('业务处理失败: $e');
  return null;
}

// Core 层：技术错误处理
if (!_isLoaded) {
  throw Exception('模块未加载');
}
```

### 2. 常见错误类型

| 错误类型 | 原因 | 解决方案 |
|---------|------|---------|
| 模块未加载 | 调用前未初始化 | 等待 loadModule() 完成 |
| 函数不存在 | 函数名错误或未导出 | 检查 WASM 导出列表 |
| 参数类型错误 | 类型不匹配 | 确保参数类型正确 |
| 内存溢出 | 内存分配失败 | 减少内存使用或增加 WASM 内存限制 |

## 性能优化建议

### 1. 函数调用优化

```dart
// ❌ 低效：每次调用都查找函数
for (int i = 0; i < 1000; i++) {
  loader.callFunction('process', [i]);
}

// ✅ 高效：使用 cwrap 预先包装
final processFunc = loader.cwrap('process', 'number', ['number']);
for (int i = 0; i < 1000; i++) {
  processFunc(i);
}
```

### 2. 内存管理优化

```dart
// ❌ 低效：频繁 malloc/free
for (int i = 0; i < 1000; i++) {
  final ptr = loader.malloc(1024);
  // 使用 ptr...
  loader.free(ptr);
}

// ✅ 高效：重用内存缓冲区
final ptr = loader.malloc(1024);
for (int i = 0; i < 1000; i++) {
  // 重用 ptr...
}
loader.free(ptr);
```

### 3. 批量处理

```dart
// ❌ 低效：单个处理
final results = [];
for (final item in items) {
  results.add(processOne(item));
}

// ✅ 高效：批量处理
final results = batchProcess(items);
```

## 扩展指南

### 添加新的 WASM 函数

1. **在 Service 层添加方法**:
```dart
class EarthPluginService {
  ResultType newFunction(ParamType param) {
    return _loader.callFunction('native_func', [param]);
  }
}
```

2. **在 UI 层添加按钮**:
```dart
ElevatedButton(
  onPressed: () => _callNewFunction(),
  child: Text('新功能'),
)
```

3. **添加错误处理**:
```dart
try {
  final result = service.newFunction(param);
  // 处理结果
} catch (e) {
  // 处理错误
}
```

### 添加新的数据类型

```dart
class NewDataType {
  final String field1;
  final int field2;
  
  NewDataType({
    required this.field1,
    required this.field2,
  });
  
  // 转换为 WASM 可接受的格式
  List<dynamic> toWasmParams() {
    return [field1, field2];
  }
  
  // 从 WASM 结果创建实例
  factory NewDataType.fromWasmResult(dynamic result) {
    return NewDataType(
      field1: result['field1'] as String,
      field2: result['field2'] as int,
    );
  }
}
```

## 测试策略

### 1. 单元测试

```dart
test('WasmLoader 加载测试', () async {
  final loader = WasmLoader();
  await loader.loadModule();
  expect(loader.isLoaded, true);
});

test('函数调用测试', () {
  final loader = WasmLoader();
  // Mock loader...
  final result = loader.callFunction('add', [1, 2]);
  expect(result, 3);
});
```

### 2. 集成测试

```dart
testWidgets('WASM 模块加载流程测试', (tester) async {
  await tester.pumpWidget(WasmParserApp());
  await tester.pumpAndSettle();
  
  // 验证状态显示
  expect(find.text('WASM 模块加载成功！'), findsOneWidget);
});
```

### 3. 性能测试

```dart
test('批量处理性能测试', () async {
  final service = EarthPluginService(WasmLoader());
  await service.initialize();
  
  final stopwatch = Stopwatch()..start();
  final data = List.generate(10000, (i) => i.toDouble());
  service.batchProcess(data);
  stopwatch.stop();
  
  expect(stopwatch.elapsedMilliseconds, lessThan(1000));
});
```

## 安全性考虑

1. **输入验证**: 验证所有传递给 WASM 的参数
2. **内存安全**: 确保正确释放分配的内存
3. **错误边界**: 捕获所有可能的异常
4. **CORS 设置**: 正确配置跨域资源共享

## 部署指南

### 开发环境
```bash
flutter run -d chrome
```

### 生产构建
```bash
flutter build web --release
```

### 服务器配置

确保服务器正确设置 MIME 类型：
```
.wasm → application/wasm
.js   → application/javascript
```

## 总结

本架构采用**清晰的分层设计**、**面向对象的编程范式**和**最佳实践**，实现了：

- ✅ 高度可维护性
- ✅ 良好的可扩展性
- ✅ 类型安全
- ✅ 错误处理完善
- ✅ 性能优化
- ✅ 易于测试

通过这个架构，您可以轻松地集成任何 Emscripten 编译的 WASM 模块到 Dart/Flutter 应用中。


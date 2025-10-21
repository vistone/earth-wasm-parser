import 'dart:js' as js;
import '../wasm_loader.dart';
import '../earth_plugin_service.dart';

/// WASM 使用示例类
/// 
/// 这个类展示了如何在实际项目中使用 WasmLoader 和 EarthPluginService
class WasmUsageExample {
  
  /// 示例 1: 基础加载和调用
  static Future<void> basicUsageExample() async {
    print('=== 示例 1: 基础使用 ===\n');
    
    // 1. 创建加载器实例
    final loader = WasmLoader();
    
    // 2. 加载模块
    print('正在加载 WASM 模块...');
    await loader.loadModule();
    print('✓ 模块加载成功\n');
    
    // 3. 获取模块信息
    final info = loader.getModuleInfo();
    print('模块信息:');
    print(info);
    print('');
    
    // 4. 调用导出的函数（示例）
    try {
      // 假设有一个简单的加法函数
      final result = loader.callFunction('add', [10, 20]);
      print('调用 add(10, 20) = $result\n');
    } catch (e) {
      print('函数调用示例: $e\n');
    }
  }

  /// 示例 2: 使用服务类封装
  static Future<void> serviceUsageExample() async {
    print('=== 示例 2: 使用服务类 ===\n');
    
    // 1. 创建加载器和服务
    final loader = WasmLoader();
    final service = EarthPluginService(loader);
    
    // 2. 初始化服务
    print('正在初始化服务...');
    final initialized = await service.initialize();
    
    if (!initialized) {
      print('✗ 服务初始化失败\n');
      return;
    }
    print('✓ 服务初始化成功\n');
    
    // 3. 获取版本信息
    final version = service.getVersion();
    if (version != null) {
      print('插件版本: $version');
    }
    
    // 4. 获取统计信息
    final stats = service.getStats();
    print('\n统计信息:');
    print(stats);
    
    // 5. 调用业务功能（示例）
    try {
      // 坐标转换示例
      final coord = service.convertCoordinate(39.9042, 116.4074);
      if (coord != null) {
        print('坐标转换结果: $coord');
      }
      
      // 字符串处理示例
      final processed = service.processString('Hello WASM');
      if (processed != null) {
        print('字符串处理结果: $processed');
      }
    } catch (e) {
      print('业务调用示例: $e');
    }
    
    // 6. 清理资源
    service.dispose();
    print('\n✓ 资源已清理');
  }

  /// 示例 3: 内存管理
  static Future<void> memoryManagementExample() async {
    print('=== 示例 3: 内存管理 ===\n');
    
    final loader = WasmLoader();
    await loader.loadModule();
    
    // 1. 分配内存
    print('分配 1024 字节内存...');
    final ptr = loader.malloc(1024);
    print('✓ 内存地址: $ptr\n');
    
    // 2. 使用内存进行操作
    // 这里可以调用 WASM 函数操作这块内存
    print('使用内存进行数据处理...\n');
    
    // 3. 释放内存
    print('释放内存...');
    loader.free(ptr);
    print('✓ 内存已释放\n');
  }

  /// 示例 4: 使用 ccall 调用 C 函数
  static Future<void> ccallExample() async {
    print('=== 示例 4: 使用 ccall ===\n');
    
    final loader = WasmLoader();
    await loader.loadModule();
    
    try {
      // 调用一个 C 函数，传递不同类型的参数
      final result = loader.ccall(
        'calculate',           // 函数名
        'number',              // 返回类型: 'number', 'string', 'array', null
        ['number', 'number'],  // 参数类型数组
        [42, 8],              // 参数值数组
      );
      
      print('ccall 结果: $result\n');
    } catch (e) {
      print('ccall 示例: $e\n');
    }
  }

  /// 示例 5: 使用 cwrap 包装函数
  static Future<void> cwrapExample() async {
    print('=== 示例 5: 使用 cwrap ===\n');
    
    final loader = WasmLoader();
    await loader.loadModule();
    
    try {
      // 包装一个频繁调用的函数
      final addFunction = loader.cwrap(
        'add',
        'number',
        ['number', 'number'],
      );
      
      if (addFunction != null) {
        // 多次调用包装后的函数（性能更好）
        print('调用包装后的函数:');
        if (addFunction is js.JsFunction) {
          for (int i = 0; i < 5; i++) {
            final result = addFunction.apply([i, i * 2]);
            print('  add($i, ${i * 2}) = $result');
          }
        }
        print('');
      }
    } catch (e) {
      print('cwrap 示例: $e\n');
    }
  }

  /// 示例 6: 错误处理
  static Future<void> errorHandlingExample() async {
    print('=== 示例 6: 错误处理 ===\n');
    
    final loader = WasmLoader();
    
    // 1. 未加载时调用函数
    try {
      loader.callFunction('some_function', []);
    } catch (e) {
      print('✓ 捕获到预期错误: $e\n');
    }
    
    // 2. 加载模块
    await loader.loadModule();
    
    // 3. 调用不存在的函数
    try {
      loader.callFunction('nonexistent_function', []);
    } catch (e) {
      print('✓ 捕获到函数不存在错误: $e\n');
    }
    
    // 4. 传递错误的参数类型
    try {
      loader.ccall(
        'some_function',
        'number',
        ['number'],
        ['not a number'], // 错误的参数类型
      );
    } catch (e) {
      print('✓ 捕获到参数类型错误: $e\n');
    }
  }

  /// 示例 7: 异步批量处理
  static Future<void> batchProcessingExample() async {
    print('=== 示例 7: 异步批量处理 ===\n');
    
    final loader = WasmLoader();
    final service = EarthPluginService(loader);
    await service.initialize();
    
    // 准备批量数据
    final dataList = List.generate(10, (i) => i.toDouble());
    print('输入数据: $dataList\n');
    
    // 批量处理
    print('正在批量处理...');
    final results = service.batchProcess(dataList);
    
    if (results != null) {
      print('✓ 处理完成');
      print('输出数据: $results\n');
    } else {
      print('✗ 批量处理失败\n');
    }
    
    service.dispose();
  }

  /// 运行所有示例
  static Future<void> runAllExamples() async {
    print('\n╔════════════════════════════════════════╗');
    print('║   WASM 使用示例集合                    ║');
    print('╚════════════════════════════════════════╝\n');
    
    try {
      await basicUsageExample();
      await Future.delayed(const Duration(seconds: 1));
      
      await serviceUsageExample();
      await Future.delayed(const Duration(seconds: 1));
      
      await memoryManagementExample();
      await Future.delayed(const Duration(seconds: 1));
      
      await ccallExample();
      await Future.delayed(const Duration(seconds: 1));
      
      await cwrapExample();
      await Future.delayed(const Duration(seconds: 1));
      
      await errorHandlingExample();
      await Future.delayed(const Duration(seconds: 1));
      
      await batchProcessingExample();
      
      print('\n✓ 所有示例执行完成！');
    } catch (e) {
      print('\n✗ 示例执行出错: $e');
    }
  }
}

/// 在 main.dart 中使用示例：
/// 
/// ```dart
/// import 'examples/wasm_usage_example.dart';
/// 
/// void main() async {
///   // 运行所有示例
///   await WasmUsageExample.runAllExamples();
///   
///   // 或运行单个示例
///   await WasmUsageExample.basicUsageExample();
/// }
/// ```


import 'wasm_loader.dart';

/// EarthPlugin WASM 服务类
/// 这是一个面向对象的封装，用于调用 earthplugin_web.wasm 的具体功能
class EarthPluginService {
  final WasmLoader _loader;
  
  EarthPluginService(this._loader);

  /// 检查服务是否可用
  bool get isReady => _loader.isLoaded;

  /// 初始化插件
  /// 返回初始化结果
  Future<bool> initialize() async {
    try {
      if (!_loader.isLoaded) {
        await _loader.loadModule();
      }
      
      // 如果 WASM 有初始化函数，在这里调用
      // 例如: _loader.callFunction('init', []);
      
      return true;
    } catch (e) {
      print('初始化失败: $e');
      return false;
    }
  }

  /// 示例：处理地球坐标转换
  /// 
  /// 这是一个示例方法，展示如何调用 WASM 函数
  /// 根据实际的 earthplugin_web.wasm 导出的函数进行修改
  CoordinateResult? convertCoordinate(double latitude, double longitude) {
    if (!isReady) {
      throw Exception('服务未初始化');
    }

    try {
      // 示例调用方式（根据实际函数修改）
      // 假设 WASM 有一个 convert_coordinate 函数
      final result = _loader.ccall(
        'convert_coordinate',
        'number',
        ['number', 'number'],
        [latitude, longitude],
      );

      // 解析结果
      return CoordinateResult(
        x: result['x'] as double? ?? 0.0,
        y: result['y'] as double? ?? 0.0,
        z: result['z'] as double? ?? 0.0,
      );
    } catch (e) {
      print('坐标转换失败: $e');
      return null;
    }
  }

  /// 示例：处理字符串数据
  /// 
  /// 展示如何传递字符串参数并接收字符串结果
  String? processString(String input) {
    if (!isReady) {
      throw Exception('服务未初始化');
    }

    try {
      // 使用 ccall 处理字符串
      final result = _loader.ccall(
        'process_string',
        'string',
        ['string'],
        [input],
      );

      return result as String?;
    } catch (e) {
      print('字符串处理失败: $e');
      return null;
    }
  }

  /// 示例：批量处理数据
  /// 
  /// 展示如何传递数组数据
  List<double>? batchProcess(List<double> data) {
    if (!isReady) {
      throw Exception('服务未初始化');
    }

    try {
      // 分配内存并复制数据
      final size = data.length * 8; // 8 bytes per double
      final ptr = _loader.malloc(size);
      
      // 这里需要将 Dart 数组写入 WASM 内存
      // 实际实现需要使用 Module 的内存操作函数
      
      // 调用 WASM 函数处理数据
      // final resultPtr = _loader.callFunction('batch_process', [ptr, data.length]);
      
      // 读取结果并释放内存
      _loader.free(ptr);
      
      // 返回结果数组
      return data.map((e) => e * 2).toList(); // 示例返回
    } catch (e) {
      print('批量处理失败: $e');
      return null;
    }
  }

  /// 获取插件版本信息
  PluginVersion? getVersion() {
    if (!isReady) {
      throw Exception('服务未初始化');
    }

    try {
      // 假设有 get_version 函数
      final versionCode = _loader.callFunction('get_version', []) as int? ?? 0;
      
      final major = (versionCode >> 16) & 0xFF;
      final minor = (versionCode >> 8) & 0xFF;
      final patch = versionCode & 0xFF;
      
      return PluginVersion(
        major: major,
        minor: minor,
        patch: patch,
      );
    } catch (e) {
      print('获取版本失败: $e');
      return null;
    }
  }

  /// 获取插件统计信息
  PluginStats getStats() {
    if (!isReady) {
      throw Exception('服务未初始化');
    }

    try {
      final info = _loader.getModuleInfo();
      
      return PluginStats(
        moduleName: 'EarthPlugin',
        memoryUsage: info.memorySize,
        exportedFunctionsCount: info.exportedFunctions.length,
        isInitialized: true,
      );
    } catch (e) {
      print('获取统计信息失败: $e');
      return PluginStats(
        moduleName: 'EarthPlugin',
        memoryUsage: 0,
        exportedFunctionsCount: 0,
        isInitialized: false,
      );
    }
  }

  /// 清理资源
  void dispose() {
    // 如果需要，调用 WASM 的清理函数
    // _loader.callFunction('cleanup', []);
  }
}

/// 坐标结果类
class CoordinateResult {
  final double x;
  final double y;
  final double z;

  CoordinateResult({
    required this.x,
    required this.y,
    required this.z,
  });

  @override
  String toString() => 'CoordinateResult(x: $x, y: $y, z: $z)';
}

/// 插件版本信息类
class PluginVersion {
  final int major;
  final int minor;
  final int patch;

  PluginVersion({
    required this.major,
    required this.minor,
    required this.patch,
  });

  @override
  String toString() => '$major.$minor.$patch';
}

/// 插件统计信息类
class PluginStats {
  final String moduleName;
  final int memoryUsage;
  final int exportedFunctionsCount;
  final bool isInitialized;

  PluginStats({
    required this.moduleName,
    required this.memoryUsage,
    required this.exportedFunctionsCount,
    required this.isInitialized,
  });

  @override
  String toString() {
    return '''
模块名称: $moduleName
内存使用: ${(memoryUsage / 1024 / 1024).toStringAsFixed(2)} MB
导出函数数量: $exportedFunctionsCount
初始化状态: ${isInitialized ? "已初始化" : "未初始化"}
''';
  }
}


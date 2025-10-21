import 'package:flutter/material.dart';
import 'wasm_loader.dart';
import 'earth_plugin_service.dart';

/// 演示应用程序 - 展示如何使用 WASM 模块
/// 
/// 这是一个简化版本的演示，展示核心功能
class WasmDemoApp extends StatelessWidget {
  const WasmDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WASM Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  late final WasmLoader _loader;
  late final EarthPluginService _service;
  
  bool _isInitialized = false;
  String _statusMessage = '等待初始化...';
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _loader = WasmLoader();
    _service = EarthPluginService(_loader);
    _initialize();
  }

  Future<void> _initialize() async {
    _addLog('开始初始化 WASM 模块...');
    
    try {
      final success = await _service.initialize();
      
      if (success) {
        setState(() {
          _isInitialized = true;
          _statusMessage = '✓ 初始化成功';
        });
        _addLog('✓ WASM 模块初始化成功');
        
        // 获取模块信息
        final info = _loader.getModuleInfo();
        _addLog('模块类型: ${info.moduleType}');
        _addLog('导出函数数量: ${info.exportedFunctions.length}');
        _addLog('内存大小: ${(info.memorySize / 1024).toStringAsFixed(2)} KB');
      } else {
        setState(() {
          _statusMessage = '✗ 初始化失败';
        });
        _addLog('✗ WASM 模块初始化失败');
      }
    } catch (e) {
      setState(() {
        _statusMessage = '✗ 错误: $e';
      });
      _addLog('✗ 错误: $e');
    }
  }

  void _addLog(String message) {
    setState(() {
      _logs.add('[${DateTime.now().toString().substring(11, 19)}] $message');
    });
  }

  void _testCoordinateConversion() {
    _addLog('');
    _addLog('测试坐标转换功能...');
    
    try {
      final result = _service.convertCoordinate(39.9042, 116.4074);
      if (result != null) {
        _addLog('✓ 输入: 纬度=39.9042, 经度=116.4074');
        _addLog('✓ 输出: $result');
      } else {
        _addLog('✗ 坐标转换返回 null');
      }
    } catch (e) {
      _addLog('✗ 坐标转换失败: $e');
    }
  }

  void _testStringProcessing() {
    _addLog('');
    _addLog('测试字符串处理功能...');
    
    try {
      const input = 'Hello WASM from Dart!';
      _addLog('输入字符串: "$input"');
      
      final result = _service.processString(input);
      if (result != null) {
        _addLog('✓ 处理结果: "$result"');
      } else {
        _addLog('✗ 字符串处理返回 null');
      }
    } catch (e) {
      _addLog('✗ 字符串处理失败: $e');
    }
  }

  void _testBatchProcessing() {
    _addLog('');
    _addLog('测试批量处理功能...');
    
    try {
      final input = [1.0, 2.0, 3.0, 4.0, 5.0];
      _addLog('输入数据: $input');
      
      final result = _service.batchProcess(input);
      if (result != null) {
        _addLog('✓ 处理结果: $result');
      } else {
        _addLog('✗ 批量处理返回 null');
      }
    } catch (e) {
      _addLog('✗ 批量处理失败: $e');
    }
  }

  void _getVersionInfo() {
    _addLog('');
    _addLog('获取版本信息...');
    
    try {
      final version = _service.getVersion();
      if (version != null) {
        _addLog('✓ 插件版本: $version');
      } else {
        _addLog('✗ 无法获取版本信息');
      }
    } catch (e) {
      _addLog('✗ 获取版本失败: $e');
    }
  }

  void _getStatistics() {
    _addLog('');
    _addLog('获取统计信息...');
    
    try {
      final stats = _service.getStats();
      _addLog('统计信息:');
      _addLog('  - 模块名称: ${stats.moduleName}');
      _addLog('  - 内存使用: ${(stats.memoryUsage / 1024 / 1024).toStringAsFixed(2)} MB');
      _addLog('  - 导出函数数: ${stats.exportedFunctionsCount}');
      _addLog('  - 初始化状态: ${stats.isInitialized ? "已初始化" : "未初始化"}');
    } catch (e) {
      _addLog('✗ 获取统计信息失败: $e');
    }
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
    _addLog('日志已清空');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WASM 演示应用'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: '清空日志',
            onPressed: _clearLogs,
          ),
        ],
      ),
      body: Column(
        children: [
          // 状态栏
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: _isInitialized 
                ? Colors.green.shade100 
                : Colors.orange.shade100,
            child: Row(
              children: [
                Icon(
                  _isInitialized ? Icons.check_circle : Icons.hourglass_empty,
                  color: _isInitialized ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 12),
                Text(
                  _statusMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // 功能按钮
          Container(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _testCoordinateConversion : null,
                  icon: const Icon(Icons.place),
                  label: const Text('坐标转换'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _testStringProcessing : null,
                  icon: const Icon(Icons.text_fields),
                  label: const Text('字符串处理'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _testBatchProcessing : null,
                  icon: const Icon(Icons.batch_prediction),
                  label: const Text('批量处理'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getVersionInfo : null,
                  icon: const Icon(Icons.info_outline),
                  label: const Text('版本信息'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getStatistics : null,
                  icon: const Icon(Icons.analytics_outlined),
                  label: const Text('统计信息'),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // 日志区域
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: _logs.isEmpty
                  ? const Center(
                      child: Text(
                        '暂无日志',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _logs.length,
                      itemBuilder: (context, index) {
                        final log = _logs[index];
                        final isError = log.contains('✗');
                        final isSuccess = log.contains('✓');
                        final isEmpty = log.trim().isEmpty;
                        
                        if (isEmpty) {
                          return const SizedBox(height: 8);
                        }
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            log,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13,
                              color: isError
                                  ? Colors.red.shade700
                                  : isSuccess
                                      ? Colors.green.shade700
                                      : Colors.black87,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}

/// 运行演示应用的主函数
void runDemoApp() {
  runApp(const WasmDemoApp());
}


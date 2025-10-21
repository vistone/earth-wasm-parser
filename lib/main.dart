import 'package:flutter/material.dart';
import 'wasm_loader.dart';

void main() {
  runApp(const WasmParserApp());
}

/// 主应用程序类
class WasmParserApp extends StatelessWidget {
  const WasmParserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WASM Parser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const WasmParserHomePage(),
    );
  }
}

/// 主页面类
class WasmParserHomePage extends StatefulWidget {
  const WasmParserHomePage({super.key});

  @override
  State<WasmParserHomePage> createState() => _WasmParserHomePageState();
}

class _WasmParserHomePageState extends State<WasmParserHomePage> {
  final WasmLoader _wasmLoader = WasmLoader();
  String _status = '等待加载...';
  String _output = '';
  bool _isLoading = false;
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWasm();
  }

  /// 加载 WASM 模块
  Future<void> _loadWasm() async {
    setState(() {
      _isLoading = true;
      _status = '正在加载 WASM 模块...';
    });

    try {
      await _wasmLoader.loadModule();
      setState(() {
        _status = 'WASM 模块加载成功！';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _status = '加载失败: $e';
        _isLoading = false;
      });
    }
  }

  /// 调用 WASM 函数
  void _callWasmFunction() {
    if (!_wasmLoader.isLoaded) {
      setState(() {
        _output = '错误：WASM 模块未加载';
      });
      return;
    }

    try {
      final input = _inputController.text;
      final result = _wasmLoader.callFunction('test_function', [input]);
      setState(() {
        _output = '结果: $result';
      });
    } catch (e) {
      setState(() {
        _output = '调用失败: $e';
      });
    }
  }

  /// 获取模块信息
  void _getModuleInfo() {
    if (!_wasmLoader.isLoaded) {
      setState(() {
        _output = '错误：WASM 模块未加载';
      });
      return;
    }

    try {
      final info = _wasmLoader.getModuleInfo();
      setState(() {
        _output = '模块信息:\n${info.toString()}';
      });
    } catch (e) {
      setState(() {
        _output = '获取信息失败: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WASM Parser - Dart 调用示例'),
        elevation: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceVariant,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 状态卡片
                  _buildStatusCard(),
                  const SizedBox(height: 24),

                  // 输入区域
                  _buildInputCard(),
                  const SizedBox(height: 24),

                  // 操作按钮
                  _buildActionButtons(),
                  const SizedBox(height: 24),

                  // 输出区域
                  _buildOutputCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建状态卡片
  Widget _buildStatusCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _isLoading
                      ? Icons.hourglass_empty
                      : _wasmLoader.isLoaded
                          ? Icons.check_circle
                          : Icons.error,
                  color: _isLoading
                      ? Colors.orange
                      : _wasmLoader.isLoaded
                          ? Colors.green
                          : Colors.red,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '模块状态',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _status,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  /// 构建输入卡片
  Widget _buildInputCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '输入参数',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                hintText: '输入要传递给 WASM 的参数...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  /// 构建操作按钮
  Widget _buildActionButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: _isLoading ? null : _loadWasm,
          icon: const Icon(Icons.refresh),
          label: const Text('重新加载模块'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        ElevatedButton.icon(
          onPressed: _wasmLoader.isLoaded ? _callWasmFunction : null,
          icon: const Icon(Icons.play_arrow),
          label: const Text('调用函数'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        ElevatedButton.icon(
          onPressed: _wasmLoader.isLoaded ? _getModuleInfo : null,
          icon: const Icon(Icons.info_outline),
          label: const Text('获取模块信息'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ],
    );
  }

  /// 构建输出卡片
  Widget _buildOutputCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '输出结果',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Text(
                _output.isEmpty ? '暂无输出' : _output,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}


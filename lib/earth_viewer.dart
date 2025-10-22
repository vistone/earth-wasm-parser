import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;

/// 地球查看器 Widget - 使用 Dart 加载 WASM 并渲染地球
class EarthViewer extends StatefulWidget {
  const EarthViewer({super.key});

  @override
  State<EarthViewer> createState() => _EarthViewerState();
}

class _EarthViewerState extends State<EarthViewer> {
  String _status = '正在初始化...';
  bool _isLoading = true;
  final String _canvasId = 'earth-canvas';
  html.CanvasElement? _canvas;

  @override
  void initState() {
    super.initState();
    _initializeEarth();
  }

  /// 自动初始化并加载地球
  Future<void> _initializeEarth() async {
    try {
      setState(() {
        _status = '正在创建 Canvas...';
        _isLoading = true;
      });

      // 1. 创建 Canvas 元素
      _createCanvas();

      // 等待 Canvas 注册
      await Future.delayed(const Duration(milliseconds: 100));

      setState(() {
        _status = '正在配置 Module...';
      });

      // 2. 配置 Emscripten Module
      _configureModule();

      setState(() {
        _status = '正在加载 WASM...';
      });

      // 3. 加载 WASM 模块
      await _loadWasmModule();

      setState(() {
        _status = '✅ 地球加载成功！';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _status = '❌ 加载失败: $e';
        _isLoading = false;
      });
      print('地球初始化失败: $e');
    }
  }

  /// 创建 Canvas 元素（满屏显示）
  void _createCanvas() {
    // 获取窗口大小
    final width = html.window.innerWidth ?? 1920;
    final height = html.window.innerHeight ?? 1080;

    _canvas = html.CanvasElement()
      ..id = _canvasId
      ..width = width
      ..height = height
      ..style.width = '100vw'
      ..style.height = '100vh'
      ..style.position = 'fixed'
      ..style.left = '0'
      ..style.top = '0'
      ..style.right = '0'
      ..style.bottom = '0'
      ..style.margin = '0'
      ..style.padding = '0'
      ..style.border = 'none'
      ..style.outline = 'none'
      ..style.pointerEvents = 'auto'
      ..style.touchAction = 'none'
      ..setAttribute('oncontextmenu', 'event.preventDefault()')
      ..setAttribute('tabindex', '1');

    // 直接添加到 body
    html.document.body?.append(_canvas!);

    print('[Dart] Canvas 已直接挂载到 DOM: $_canvasId (${width}x${height})');

    // 监听窗口大小变化
    html.window.onResize.listen((event) {
      final newWidth = html.window.innerWidth ?? 1920;
      final newHeight = html.window.innerHeight ?? 1080;
      _canvas?.width = newWidth;
      _canvas?.height = newHeight;
      print('[Dart] Canvas 大小已更新: ${newWidth}x${newHeight}');

      // 调用 WASM 的 ResizeViewport
      final module = js.context['Module'];
      if (module != null && module is js.JsObject) {
        final resize = module['ResizeViewport'];
        if (resize != null && resize is js.JsFunction) {
          resize.apply([newWidth, newHeight]);
          print('[Dart] ResizeViewport($newWidth, $newHeight) 已调用');
        }
      }
    });
  }

  /// 配置 Emscripten Module 对象（参考成功的 HTML）
  void _configureModule() {
    if (_canvas == null) {
      throw Exception('Canvas 对象为 null');
    }

    print('[Dart] 配置 Module，参考成功的逻辑');

    const base64Init =
        'GgpFbXNjcmlwdGVuKgV6aF9DTjInQUl6YVN5RDhKYTVBSUlpSFZtZ0RBTmhwNXlnT0FrYklpMmhCWjVBWAFgAXgBgAEBkgEJMTAuOTEuMC4xqAEBsgEnQUl6YVN5QUFqWEY4dHRvRWlVMkdZU3dtUkJ2aU8wdHdVODNGa3lB';

    // 监听 earth-wasm-started 事件
    html.window.addEventListener('earth-wasm-started', (event) {
      print('[事件] earth-wasm-started 触发');

      final module = js.context['Module'] as js.JsObject;

      // 按照参考 HTML 的方式配置
      module['canvas'] = _canvas;
      module['print'] = null;
      module['printErr'] = null;
      module['initArguments'] = js.JsArray.from([base64Init]);
      module['earth-ready'] = true;

      print('[Dart] Module 重新配置完成');
      print('[Dart] ccall 类型: ${module['ccall']?.runtimeType}');
      print('[Dart] _initialize 类型: ${module['_initialize']?.runtimeType}');

      // 调用 ccall("initialize", null, ["string"], [BASE64_INIT])
      final ccall = module['ccall'];
      if (ccall != null && ccall is js.JsFunction) {
        try {
          print('[Dart] 调用 ccall("initialize")');
          final ret = ccall.apply([
            'initialize',
            null,
            js.JsArray.from(['string']),
            js.JsArray.from([base64Init]),
          ]);
          print('[Dart] initialize 返回: $ret');

          // 检查状态
          Future.delayed(const Duration(seconds: 1), () {
            print('[Dart] earth-ready: ${module['earth-ready']}');
            print('[Dart] ctx: ${module['ctx'] != null}');

            // 调用 ResizeViewport（使用实际窗口大小）
            final resize = module['ResizeViewport'];
            if (resize != null && resize is js.JsFunction) {
              final width = html.window.innerWidth ?? 1920;
              final height = html.window.innerHeight ?? 1080;
              resize.apply([width, height]);
              print('[Dart] ResizeViewport($width, $height) 已调用');
            }

            // 检查函数
            print(
                '[Dart] ReceiveViewModelCommand: ${module['ReceiveViewModelCommand']?.runtimeType}');
          });
        } catch (e) {
          print('[Dart] ccall 调用出错: $e');
        }
      }
    });

    print('[Dart] 已设置 earth-wasm-started 监听器');
  }

  /// 加载 WASM 模块
  Future<void> _loadWasmModule() async {
    // 检查是否已经加载过脚本
    final existingScript =
        html.document.querySelector('script[src="wasm/earthplugin_web.js"]');
    if (existingScript != null) {
      print('[Dart] WASM JS 文件已存在，跳过重复加载');
      await Future.delayed(const Duration(seconds: 3));
      return;
    }

    // 创建 script 标签加载 JS 文件
    final script = html.ScriptElement()
      ..src = 'wasm/earthplugin_web.js'
      ..type = 'text/javascript';

    final completer = Future<void>.delayed(Duration.zero);

    script.onLoad.listen((_) {
      print('[Dart] WASM JS 文件加载成功');
    });

    script.onError.listen((event) {
      print('[Dart] WASM JS 文件加载失败');
      throw Exception('加载 WASM JS 失败');
    });

    html.document.head?.append(script);

    // 等待加载和初始化
    await completer;
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          children: [
            // 加载中的中心提示
            if (_isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

            // 浮动状态栏（右上角）
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: _isLoading
                      ? Colors.orange.withOpacity(0.8)
                      : Colors.green.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else
                      const Icon(Icons.check_circle,
                          color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      _status,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
    // 清理资源
    super.dispose();
  }
}

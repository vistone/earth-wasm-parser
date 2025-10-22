import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui_web' as ui_web;

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

  /// 创建 Canvas 元素
  void _createCanvas() {
    _canvas = html.CanvasElement()
      ..id = _canvasId
      ..width = 800
      ..height = 600
      ..style.width = '800px'
      ..style.height = '600px'
      ..style.position = 'absolute'
      ..style.left = '50%'
      ..style.top = '50%'
      ..style.transform = 'translate(-50%, -50%)'
      ..style.pointerEvents = 'auto'
      ..style.touchAction = 'none'
      ..setAttribute('oncontextmenu', 'event.preventDefault()')
      ..setAttribute('tabindex', '1');

    // 直接添加到 body（不使用 HtmlElementView）
    html.document.body?.append(_canvas!);

    // 添加鼠标控制
    _setupMouseControl();

    print('[Dart] Canvas 已直接挂载到 DOM: $_canvasId');
  }

  /// 设置鼠标控制
  void _setupMouseControl() {
    print('[Dart] 准备注入鼠标控制脚本');
  }

  /// 注入鼠标控制（使用最小化的 protobuf 数据）
  void _injectMouseControl() {
    final jsCode = '''
    (function() {
      const canvas = document.getElementById('earth-canvas');
      if (!canvas) {
        console.log('[鼠标] Canvas 未找到');
        return;
      }
      
      canvas.focus();
      
      // 检查 WASM 事件注册状态
      setTimeout(() => {
        const hasWasmEvents = canvas.onmousedown !== null;
        console.log('[鼠标] WASM 已注册事件:', hasWasmEvents);
        
        if (hasWasmEvents) {
          console.log('[鼠标] WASM 自己处理，无需手动注册');
          return;
        }
        
        // WASM 没有注册，我们手动注册
        console.log('[鼠标] 手动注册事件并调用 ReceiveViewModelCommand');
        
        let isDown = false;
        
        // 编码鼠标事件到 protobuf 格式
        function encodeMouseDown(x, y) {
          // mousedown: 28 bytes
          const buf = new ArrayBuffer(28);
          const view = new DataView(buf);
          const arr = new Uint8Array(buf);
          
          arr[0] = 18;  // field tag
          arr[1] = 26;  // length = 26
          arr[2] = 8;   // field 1
          arr[3] = 1;   // value: 1
          arr[4] = 16;  // field 2
          arr[5] = 4;   // value: 4 (button pressed)
          arr[6] = 24;  // field 3
          arr[7] = 1;   // value: 1 (mousedown type)
          arr[8] = 32;  // field 4
          arr[9] = 1;   // value: 1
          arr[10] = 41; // field 5, type double
          view.setFloat64(11, x, true);  // X coordinate
          arr[19] = 49; // field 6, type double
          view.setFloat64(20, y, true);  // Y coordinate
          
          return arr;
        }
        
        function encodeMouseMove(x, y) {
          // mousemove: 26 bytes
          const buf = new ArrayBuffer(26);
          const view = new DataView(buf);
          const arr = new Uint8Array(buf);
          
          arr[0] = 18;  // field tag
          arr[1] = 24;  // length = 24
          arr[2] = 8;   // field 1
          arr[3] = 1;   // value: 1
          arr[4] = 16;  // field 2
          arr[5] = 0;   // value: 0 (no button)
          arr[6] = 24;  // field 3
          arr[7] = 3;   // value: 3 (mousemove type)
          arr[8] = 41;  // field 5, type double
          view.setFloat64(9, x, true);   // X coordinate
          arr[17] = 49; // field 6, type double
          view.setFloat64(18, y, true);  // Y coordinate
          
          return arr;
        }
        
        function encodeMouseUp(x, y) {
          // mouseup: 28 bytes (similar to mousedown)
          const buf = new ArrayBuffer(28);
          const view = new DataView(buf);
          const arr = new Uint8Array(buf);
          
          arr[0] = 18;
          arr[1] = 26;
          arr[2] = 8;
          arr[3] = 1;
          arr[4] = 16;
          arr[5] = 4;   // button state
          arr[6] = 24;
          arr[7] = 2;   // value: 2 (mouseup type)
          arr[8] = 32;
          arr[9] = 0;
          arr[10] = 41;
          view.setFloat64(11, x, true);
          arr[19] = 49;
          view.setFloat64(20, y, true);
          
          return arr;
        }
        
        canvas.addEventListener('mousedown', (e) => {
          isDown = true;
          if (window.Module && window.Module.ReceiveViewModelCommand) {
            try {
              const data = encodeMouseDown(e.clientX, e.clientY);
              window.Module.ReceiveViewModelCommand('earth.InputEvent', data);
              console.log('[鼠标] mousedown:', e.clientX, e.clientY);
            } catch(err) {
              console.log('[鼠标] mousedown 错误:', err.message);
            }
          }
        });
        
        canvas.addEventListener('mousemove', (e) => {
          if (!isDown) return;
          if (window.Module && window.Module.ReceiveViewModelCommand) {
            try {
              const data = encodeMouseMove(e.clientX, e.clientY);
              window.Module.ReceiveViewModelCommand('earth.InputEvent', data);
            } catch(err) {
              console.log('[鼠标] mousemove 错误:', err.message);
            }
          }
        });
        
        canvas.addEventListener('mouseup', (e) => {
          isDown = false;
          if (window.Module && window.Module.ReceiveViewModelCommand) {
            try {
              const data = encodeMouseUp(e.clientX, e.clientY);
              window.Module.ReceiveViewModelCommand('earth.InputEvent', data);
              console.log('[鼠标] mouseup:', e.clientX, e.clientY);
            } catch(err) {
              console.log('[鼠标] mouseup 错误:', err.message);
            }
          }
        });
        
        function encodeWheel(x, y, deltaX, deltaY) {
          // wheel: 46 bytes
          const buf = new ArrayBuffer(46);
          const view = new DataView(buf);
          const arr = new Uint8Array(buf);
          
          arr[0] = 18;  // field tag
          arr[1] = 44;  // length = 44
          arr[2] = 8;   // field 1
          arr[3] = 1;   // value: 1
          arr[4] = 16;  // field 2
          arr[5] = 0;   // value: 0
          arr[6] = 24;  // field 3
          arr[7] = 4;   // value: 4 (wheel event type)
          arr[8] = 41;  // field 5, type double
          view.setFloat64(9, x, true);   // X coordinate
          arr[17] = 49; // field 6, type double
          view.setFloat64(18, y, true);  // Y coordinate
          arr[26] = 57; // field 7, type double
          view.setFloat64(27, deltaX, true);  // wheel delta X
          arr[35] = 65; // field 8, type double
          view.setFloat64(36, deltaY, true);  // wheel delta Y
          arr[44] = 80; // field 10
          arr[45] = 1;  // value: 1
          
          return arr;
        }
        
        canvas.addEventListener('wheel', (e) => {
          e.preventDefault();
          if (window.Module && window.Module.ReceiveViewModelCommand) {
            try {
              const data = encodeWheel(e.clientX, e.clientY, e.deltaX, e.deltaY);
              window.Module.ReceiveViewModelCommand('earth.InputEvent', data);
              console.log('[鼠标] wheel:', e.deltaX, e.deltaY);
            } catch(err) {
              console.log('[鼠标] wheel 错误:', err.message);
            }
          }
        });
        
        console.log('[鼠标] 事件已注册');
      }, 1500);
    })();
    ''';

    js.context.callMethod('eval', [jsCode]);
    print('[Dart] 鼠标控制已注入');
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

            // 调用 ResizeViewport
            final resize = module['ResizeViewport'];
            if (resize != null && resize is js.JsFunction) {
              resize.apply([800, 600]);
              print('[Dart] ResizeViewport(800, 600) 已调用');
            }

            // 检查函数
            print(
                '[Dart] ReceiveViewModelCommand: ${module['ReceiveViewModelCommand']?.runtimeType}');

            // 注入鼠标控制脚本（因为 WASM 不会自动注册）
            Future.delayed(const Duration(milliseconds: 500), () {
              _injectMouseControl();
            });
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
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // 状态栏
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color:
                  _isLoading ? Colors.orange.shade100 : Colors.green.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                const SizedBox(width: 12),
                Text(
                  _status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isLoading
                        ? Colors.orange.shade900
                        : Colors.green.shade900,
                  ),
                ),
              ],
            ),
          ),

          // Canvas 容器（地球渲染区域）
          Expanded(
            child: Container(
              color: Colors.black,
              child: Center(
                child: _isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
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
                      )
                    : const Center(
                        child: Text(
                          'Canvas 已直接挂载到 DOM',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 清理资源
    super.dispose();
  }
}

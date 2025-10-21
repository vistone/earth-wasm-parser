import 'dart:js' as js;
import 'dart:html' as html;

/// WASM 模块信息类
class WasmModuleInfo {
  final List<String> exportedFunctions;
  final int memorySize;
  final String moduleType;

  WasmModuleInfo({
    required this.exportedFunctions,
    required this.memorySize,
    required this.moduleType,
  });

  @override
  String toString() {
    return '''
导出函数: ${exportedFunctions.join(', ')}
内存大小: $memorySize bytes
模块类型: $moduleType
''';
  }
}

/// WASM 加载器类 - 负责加载和管理 WASM 模块
class WasmLoader {
  dynamic _module;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  /// 加载 WASM 模块
  Future<void> loadModule() async {
    try {
      // 创建 script 标签来加载 Emscripten 生成的 JS 文件
      final script = html.ScriptElement()
        ..src = 'wasm/earthplugin_web.js'
        ..type = 'text/javascript';

      // 创建一个完成器来等待脚本加载
      final completer = Future<void>.delayed(Duration.zero);

      script.onLoad.listen((_) async {
        print('JavaScript 加载成功');
        
        // 等待一小段时间让 Module 初始化
        await Future.delayed(const Duration(milliseconds: 500));

        // 获取全局的 Module 对象
        try {
          _module = js.context['Module'];
          
          if (_module == null) {
            throw Exception('Module 对象未找到');
          }

          // 等待 Module 初始化完成
          await _waitForModuleReady();
          
          _isLoaded = true;
          print('WASM 模块加载成功');
        } catch (e) {
          print('获取 Module 对象失败: $e');
          throw Exception('无法获取 Module 对象: $e');
        }
      });

      script.onError.listen((event) {
        print('JavaScript 加载失败: $event');
        throw Exception('加载 JavaScript 失败');
      });

      // 添加脚本到文档
      html.document.head?.append(script);

      // 等待加载完成
      await completer;
      await Future.delayed(const Duration(seconds: 2));
      
    } catch (e) {
      print('加载模块时出错: $e');
      _isLoaded = false;
      rethrow;
    }
  }

  /// 等待 Module 准备就绪
  Future<void> _waitForModuleReady() async {
    int attempts = 0;
    const maxAttempts = 50;
    
    while (attempts < maxAttempts) {
      try {
        // 检查 Module 是否有 _malloc 函数（表示已初始化）
        final hasMethod = _hasMethod(_module, '_malloc');
        if (hasMethod) {
          print('Module 已准备就绪');
          return;
        }
      } catch (e) {
        print('等待 Module 准备就绪时出错: $e');
      }
      
      await Future.delayed(const Duration(milliseconds: 100));
      attempts++;
    }
    
    throw Exception('Module 初始化超时');
  }

  /// 检查对象是否有指定方法
  bool _hasMethod(dynamic obj, String methodName) {
    try {
      if (obj == null) return false;
      if (obj is js.JsObject) {
        return obj.hasProperty(methodName);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// 调用 WASM 导出的函数
  dynamic callFunction(String functionName, List<dynamic> args) {
    if (!_isLoaded || _module == null) {
      throw Exception('模块未加载');
    }

    try {
      // 尝试直接调用导出的函数
      if (_module is! js.JsObject) {
        throw Exception('Module 不是有效的 JS 对象');
      }
      
      final jsModule = _module as js.JsObject;
      dynamic func = jsModule['_$functionName'];
      if (func == null) {
        // 如果没有下划线前缀，尝试不带下划线
        func = jsModule[functionName];
        if (func == null) {
          throw Exception('函数 $functionName 不存在');
        }
      }
      return _callJsFunction(func, args);
    } catch (e) {
      print('调用函数失败: $e');
      rethrow;
    }
  }

  /// 调用 JavaScript 函数的辅助方法
  dynamic _callJsFunction(dynamic func, List<dynamic> args) {
    try {
      if (func is! js.JsFunction) {
        throw Exception('不是有效的 JS 函数');
      }
      
      // 根据参数数量调用函数
      final jsArgs = [_module, ...args];
      return (func as js.JsFunction).apply(jsArgs);
    } catch (e) {
      print('调用 JS 函数失败: $e');
      rethrow;
    }
  }

  /// 获取模块信息
  WasmModuleInfo getModuleInfo() {
    if (!_isLoaded || _module == null) {
      throw Exception('模块未加载');
    }

    try {
      // 尝试获取导出的函数列表
      final functions = <String>[];
      
      // 常见的 Emscripten 导出函数
      final commonFunctions = [
        '_malloc',
        '_free',
        '_main',
        'ccall',
        'cwrap',
        'getValue',
        'setValue',
        'UTF8ToString',
        'stringToUTF8',
      ];

      for (final fname in commonFunctions) {
        if (_hasMethod(_module, fname)) {
          functions.add(fname);
        }
      }

      // 获取内存大小
      int memorySize = 0;
      try {
        final jsModule = _module as js.JsObject;
        final memory = jsModule['HEAP8'];
        if (memory != null && memory is js.JsObject) {
          memorySize = memory['length'] as int? ?? 0;
        }
      } catch (e) {
        print('获取内存大小失败: $e');
      }

      return WasmModuleInfo(
        exportedFunctions: functions,
        memorySize: memorySize,
        moduleType: 'Emscripten WASM',
      );
    } catch (e) {
      print('获取模块信息失败: $e');
      rethrow;
    }
  }

  /// 使用 ccall 调用 C 函数
  dynamic ccall(String functionName, String returnType, List<String> argTypes, List<dynamic> args) {
    if (!_isLoaded || _module == null) {
      throw Exception('模块未加载');
    }

    try {
      final jsModule = _module as js.JsObject;
      final ccallFunc = jsModule['ccall'];
      if (ccallFunc == null) {
        throw Exception('ccall 函数不可用');
      }

      if (ccallFunc is! js.JsFunction) {
        throw Exception('ccall 不是有效的函数');
      }

      return ccallFunc.apply([
        functionName,
        returnType,
        js.JsArray.from(argTypes),
        js.JsArray.from(args),
      ], thisArg: _module);
    } catch (e) {
      print('ccall 调用失败: $e');
      rethrow;
    }
  }

  /// 使用 cwrap 包装 C 函数
  dynamic cwrap(String functionName, String returnType, List<String> argTypes) {
    if (!_isLoaded || _module == null) {
      throw Exception('模块未加载');
    }

    try {
      final jsModule = _module as js.JsObject;
      final cwrapFunc = jsModule['cwrap'];
      if (cwrapFunc == null) {
        throw Exception('cwrap 函数不可用');
      }

      if (cwrapFunc is! js.JsFunction) {
        throw Exception('cwrap 不是有效的函数');
      }

      return cwrapFunc.apply([
        functionName,
        returnType,
        js.JsArray.from(argTypes),
      ], thisArg: _module);
    } catch (e) {
      print('cwrap 调用失败: $e');
      rethrow;
    }
  }

  /// 分配内存
  int malloc(int size) {
    if (!_isLoaded || _module == null) {
      throw Exception('模块未加载');
    }

    try {
      final jsModule = _module as js.JsObject;
      final mallocFunc = jsModule['_malloc'];
      if (mallocFunc == null) {
        throw Exception('malloc 函数不可用');
      }

      if (mallocFunc is! js.JsFunction) {
        throw Exception('malloc 不是有效的函数');
      }

      return mallocFunc.apply([size], thisArg: _module) as int;
    } catch (e) {
      print('malloc 调用失败: $e');
      rethrow;
    }
  }

  /// 释放内存
  void free(int ptr) {
    if (!_isLoaded || _module == null) {
      throw Exception('模块未加载');
    }

    try {
      final jsModule = _module as js.JsObject;
      final freeFunc = jsModule['_free'];
      if (freeFunc == null) {
        throw Exception('free 函数不可用');
      }

      if (freeFunc is! js.JsFunction) {
        throw Exception('free 不是有效的函数');
      }

      freeFunc.apply([ptr], thisArg: _module);
    } catch (e) {
      print('free 调用失败: $e');
      rethrow;
    }
  }
}


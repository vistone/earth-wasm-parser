import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';
import 'dart:convert';

void main() async {
  // 创建静态文件处理器，覆盖所有响应头部
  final staticHandler = createStaticHandler(
    'build/web',
    defaultDocument: 'index.html',
  );

  // 包装静态处理器以确保所有响应都有正确的头部
  final wrappedStaticHandler = _wrapWithHeaders(staticHandler);

  // 创建处理器
  final handler =
      Cascade().add(_configProxyHandler).add(wrappedStaticHandler).handler;

  // 添加头部中间件
  final cascadeHandler =
      const Pipeline().addMiddleware(_headersMiddleware()).addHandler(handler);

  // 启动服务器
  final server = await shelf_io.serve(cascadeHandler, 'localhost', 8080);

  print('✓ Dart HTTP 服务器运行: http://localhost:${server.port}');
  print('✓ SharedArrayBuffer 支持已启用');
  print('✓ 配置代理已启用');
}

// 配置文件代理处理器
Future<Response> _configProxyHandler(Request request) async {
  // 拦截 earth config 请求
  if (request.url.path.contains('earth/config') ||
      request.url.queryParameters.containsKey('alt')) {
    try {
      print('[代理] 拦截配置请求: ${request.url}');

      // 读取本地 config.base64 文件
      final configFile = File('wasm/config.base64');
      if (await configFile.exists()) {
        final base64Content = await configFile.readAsString();
        final configData = base64.decode(base64Content.trim());

        print('[代理] 返回本地配置文件，大小: ${configData.length} bytes');

        // 返回与官方相同的头部
        return Response.ok(
          configData,
          headers: {
            'Content-Type': 'text/plain',
            'x-goog-safety-content-type': 'application/x-protobuf',
            'x-goog-safety-encoding': 'base64',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Methods': 'GET, OPTIONS',
            'Access-Control-Allow-Headers': '*',
            'Cache-Control': 'private',
            'X-Content-Type-Options': 'nosniff',
            'X-Frame-Options': 'SAMEORIGIN',
          },
        );
      } else {
        print('[代理] 配置文件不存在: wasm/config.base64');
      }
    } catch (e) {
      print('[代理] 错误: $e');
    }
  }

  return Response.notFound('Not found');
}

// 包装静态处理器以添加必要的头部
Handler _wrapWithHeaders(Handler handler) {
  return (Request request) async {
    final response = await handler(request);

    // 添加跨域隔离头部（require-corp 是 SharedArrayBuffer 必需的）
    return response.change(headers: {
      'Cross-Origin-Opener-Policy': 'same-origin',
      'Cross-Origin-Embedder-Policy': 'require-corp',
      'Cross-Origin-Resource-Policy': 'cross-origin',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': '*',
      ...response.headers,
    });
  };
}

// 添加必需的 HTTP 头部中间件
Middleware _headersMiddleware() {
  return (Handler handler) {
    return (Request request) async {
      // 处理 OPTIONS 预检请求
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': '*',
          'Cross-Origin-Opener-Policy': 'same-origin',
          'Cross-Origin-Embedder-Policy': 'require-corp',
        });
      }

      final response = await handler(request);

      return response.change(headers: {
        'Cross-Origin-Opener-Policy': 'same-origin',
        'Cross-Origin-Embedder-Policy': 'require-corp',
        'Cross-Origin-Resource-Policy': 'cross-origin',
        'X-Content-Type-Options': 'nosniff',
        'Access-Control-Allow-Origin': '*',
        ...response.headers,
      });
    };
  };
}

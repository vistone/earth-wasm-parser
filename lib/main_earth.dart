/// 地球查看器主入口
/// 
/// 这个应用会自动加载 WASM 模块并渲染地球
/// 
/// 运行方式:
/// ```bash
/// flutter run -t lib/main_earth.dart -d chrome
/// ```

import 'package:flutter/material.dart';
import 'earth_viewer.dart';

void main() {
  runApp(const EarthApp());
}

/// 地球应用程序
class EarthApp extends StatelessWidget {
  const EarthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earth Viewer - WASM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const EarthViewerPage(),
    );
  }
}

/// 地球查看器页面
class EarthViewerPage extends StatelessWidget {
  const EarthViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.public, size: 24),
            SizedBox(width: 8),
            Text('Earth Viewer'),
          ],
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: const EarthViewer(),
    );
  }
}


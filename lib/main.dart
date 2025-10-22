/// 地球查看器主入口
///
/// 这个应用会自动加载 WASM 模块并渲染地球
library;

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

/// 地球查看器页面（全屏）
class EarthViewerPage extends StatelessWidget {
  const EarthViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 全屏显示，Canvas 作为背景
    return const EarthViewer();
  }
}

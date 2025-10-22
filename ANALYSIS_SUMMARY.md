# Earth WASM 完整分析总结

## 📊 全局统计

### 文件和目录

| 类别 | 数量 | 说明 |
|------|------|------|
| Proto 源文件 | 487 个 | earthplugin_web/ 目录 |
| Protobuf 消息类型 | 3,789 个 | 编译后的二进制格式 |
| 命名空间 | 455 个 | Protobuf 命名空间 |
| WASM 导出函数 | 48 个 | 已混淆，已破解 |
| Proto 文件路径 | 200+ 个 | 从 WASM 中提取 |

### 文件大小

| 文件 | 大小 | 占比 |
|------|------|------|
| earthplugin_web.wasm | 19.06 MB | 95% |
| Proto 源文件总计 | 1.13 MB | 5% |
| earthplugin_web.js | 257 KB | ~1% |
| plugins_compiled.js | 247 KB | ~1% |

## 📚 分析文档列表

### 核心分析
1. **[EARTHPLUGIN_COMPLETE_ANALYSIS.md](./EARTHPLUGIN_COMPLETE_ANALYSIS.md)** - WASM 文件完整分析
2. **[EARTHPLUGIN_WEB_DIRECTORY_ANALYSIS.md](./EARTHPLUGIN_WEB_DIRECTORY_ANALYSIS.md)** - Proto 源文件目录分析
3. **[WASM_OBFUSCATED_FUNCTIONS.md](./WASM_OBFUSCATED_FUNCTIONS.md)** - 混淆函数映射

### Protobuf 分析
4. **[COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md)** - 完整的 3,789 个消息类型
5. **[PROTO_USAGE_GUIDE.md](./PROTO_USAGE_GUIDE.md)** - Protobuf 使用指南
6. **[PBTK_EXTRACTION_SUMMARY.md](./PBTK_EXTRACTION_SUMMARY.md)** - pbtk 工具提取总结

### 详细分类
7. **[docs/proto/INDEX.md](./docs/proto/INDEX.md)** - 分类文档索引
8. **[docs/proto/earth_core.md](./docs/proto/earth_core.md)** - Earth 核心消息
9. **[docs/proto/earth_state.md](./docs/proto/earth_state.md)** - 状态管理
10. **[docs/proto/geo.md](./docs/proto/geo.md)** - 地理数据
11. **[docs/proto/maps.md](./docs/proto/maps.md)** - 地图服务

## 🎯 关键发现

### 1. Proto 定义
- **源文件**: 487 个 `.proto` 文件在 `earthplugin_web/` 目录
- **消息类型**: 3,789 个编译后的消息类型
- **主要模块**: geo, geostore, maps, google

### 2. WASM 函数
- **导出函数**: 48 个混淆函数
- **已破解**: 全部映射到真实函数名
- **关键函数**: _main, _initialize, _malloc, _free

### 3. 初始化流程
```
加载 earthplugin_web.js
  ↓
创建 WASM 实例
  ↓
触发 'earth-wasm-started' 事件
  ↓
plugins_compiled.js 监听事件
  ↓
配置 Module 对象
  ↓
调用 ccall("initialize")
  ↓
可以使用 ReceiveViewModelCommand
```

### 4. 消息传递
- **格式**: Protobuf Wire Format
- **接口**: ReceiveViewModelCommand
- **关键消息**: earth.InputEvent

## 💡 使用方法

### 初始化
```javascript
window.addEventListener('earth-wasm-started', () => {
  Module.canvas = document.getElementById('earth-canvas');
  Module.ccall("initialize", null, ["string"], [base64Init]);
});
```

### 发送事件
```javascript
const data = encodeMouseDown(x, y);
Module.ReceiveViewModelCommand('earth.InputEvent', data);
```

### 调整视口
```javascript
Module.ResizeViewport(width, height);
```

## 📖 参考

- [pbtk 工具](https://github.com/marin-m/pbtk) - Protobuf 逆向工程工具
- [Protobuf 官方文档](https://developers.google.com/protocol-buffers)
- [Emscripten 文档](https://emscripten.org/docs/introducing_emscripten/about_emscripten.html)

## ✅ 分析完成度

- ✅ Proto 文件提取和分析
- ✅ WASM 函数映射
- ✅ 初始化流程分析
- ✅ 消息类型统计
- ✅ 文档组织
- ✅ 使用指南

所有分析已完成！

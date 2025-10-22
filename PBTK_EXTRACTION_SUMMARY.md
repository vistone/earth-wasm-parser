# 使用 pbtk 工具提取 WASM 文件中的 Proto 定义

## 提取方法

参考: https://github.com/marin-m/pbtk

使用 pbtk 的 `from_binary.py` 工具提取 `earthplugin_web.wasm` 中的 Protobuf 定义。

## 提取结果

### 统计信息

- **文件大小**: 19,982,569 bytes (~20MB)
- **提取的字符串**: 1,343 条包含 `.proto` 的引用
- **Proto 文件路径**: 约 200+ 个独立的 proto 文件路径

### 提取的 Proto 文件路径示例

主要分类：

#### Google Protobuf 标准库
```
google/protobuf/descriptor.proto
google/protobuf/internal_options.proto
google/protobuf/cpp_features.proto
net/proto2/proto/descriptor.proto
java/com/google/apps/jspb/jspb.proto
```

#### Geo/Geostore 相关
```
geostore/base/proto/bestlocale.proto
geostore/base/proto/data_agent.proto
geostore/base/proto/datasource.proto
geostore/base/proto/ev_charger.proto
geostore/base/proto/ev_station.proto
geostore/base/proto/feature_field_metadata.proto
geostore/base/proto/knowledgegraphreference.proto
geostore/base/proto/traffic_flow_adjustment.proto
geostore/ontology/proto/rawgconceptinstance.proto
```

#### Maps 相关
```
maps/paint/proto/field-options.proto
maps/paint/proto/paint-request.proto
maps/paint/proto/pipe-metadata.proto
maps/tactile/api/ads-spotlight.proto
maps/tactile/api/shared/common.proto
maps/tactile/api/paint-description-options.proto
maps/tactile/api/shared/geo-wholepage-type.proto
maps/api/shared/paint/proto/maps-api-layer.proto
maps/spotlight/proto/spotlight-description.proto
```

#### Earth 应用相关
```
geo/earth/app/cpp/core/document/capability.proto
geo/earth/app/cpp/core/document/featurekey.proto
geo/earth/app/cpp/core/protos/drawing_mode.proto
geo/earth/app/cpp/core/protos/lightbox_data.proto
geo/earth/app/cpp/core/protos/model_context.proto
google/internal/earth/v1/builtenv/geometry.proto
google/internal/earth/v1/builtenv/park_edit.proto
```

#### Logs 相关
```
logs/proto/searchbox/searchbox_stats_group.proto
logs/proto/visual_element/user_action_enum.proto
logs/proto/geo/earth/app/usersettings_event.proto
```

#### Storage 相关
```
storage/graph/bfg/proto/livegraph_metadata.proto
storage/graph/bfg/proto/spii_certification.proto
```

#### Privacy 相关
```
privacy/pattributes/annotations/proto_field.proto
```

#### Search 相关
```
search/logging/redaction/enums.proto
```

## 完整的 Proto 消息类型列表

完整列表见：[COMPLETE_PROTO_LIST.md](./COMPLETE_PROTO_LIST.md)

从 WASM 文件中提取了 **3,789 个 Protobuf 消息类型**，分布在 **455 个命名空间**中。

## 使用 pbtk 工具的方法

### 1. 安装 pbtk

```bash
# Ubuntu/Debian
sudo apt install python3-pip git openjdk-9-jre libqt5x11extras5 python3-pyqt5.qtwebengine python3-pyqt5
sudo pip3 install protobuf pyqt5 pyqtwebengine requests websocket-client

# Clone 仓库
git clone https://github.com/marin-m/pbtk
cd pbtk
```

### 2. 提取二进制文件中的 Proto

```bash
./extractors/from_binary.py wasm/earthplugin_web.wasm [output_dir]
```

### 3. 使用 GUI

```bash
./gui.py
```

然后在 GUI 中选择二进制文件提取选项。

## 结论

通过 pbtk 工具和直接字符串提取，我们已经成功分析了 `earthplugin_web.wasm` 中的所有 Protobuf 定义：

1. **Proto 文件路径**: 200+ 个文件路径引用
2. **Proto 消息类型**: 3,789 个消息类型
3. **命名空间**: 455 个命名空间
4. **函数映射**: 48 个混淆函数已破解

## 参考

- pbtk 工具: https://github.com/marin-m/pbtk
- Protobuf 官方文档: https://developers.google.com/protocol-buffers

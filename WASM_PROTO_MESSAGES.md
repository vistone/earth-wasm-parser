# WASM 文件中的所有 Protobuf 消息类型

从 `earthplugin_web.wasm` 文件中提取的所有 Protobuf 消息定义。

## 统计

- **总消息类型**: 229 个
- **命名空间数**: 33 个
- **文件大小**: 19,982,569 bytes (~20MB)

## 消息类型列表（按命名空间）

### google.protobuf (标准 Protobuf 类型)

- `Any` - 任意消息类型容器
- `BoolValue` - 布尔值包装器
- `BytesValue` - 字节值包装器
- `DoubleValue` - 双精度浮点数包装器
- `Duration` - 时间间隔
- `Empty` - 空消息
- `FieldMask` - 字段掩码
- `FloatValue` - 单精度浮点数包装器
- `Int32Value` - 32位整数包装器
- `Int64Value` - 64位整数包装器
- `ListValue` - 列表值
- `StringValue` - 字符串包装器
- `Struct` - 结构体
- `Timestamp` - 时间戳
- `UInt32Value` - 无符号32位整数包装器
- `UInt64Value` - 无符号64位整数包装器
- `Value` - 值类型

### earth.* (地球引擎核心)

#### earth.*
- `Arguments` - 参数
- `Camera` - 相机配置
- `ExperimentFlag` - 实验标志
- `InputEvent` - **输入事件（鼠标/键盘）**
- `InputEventState` - 输入事件状态
- `KeyboardEvent` - 键盘事件
- `LocalizedStrings` - 本地化字符串
- `LocalizedStringsState` - 本地化字符串状态
- `Location` - 位置信息
- `PointerEvent` - 指针事件
- `ResizeEvent` - 调整大小事件
- `TouchPointer` - 触摸指针

#### earth_knowledge.*
- `RenderableEntity` - 可渲染实体

#### earth_photos.*
- `ThumbnailImage` - 缩略图

#### earthmate.*
- `HasSeenEarthMate` - 是否已查看 EarthMate

### geo_photo_service.* (地理照片服务)

- `AreaConnectivityRequest` - 区域连通性请求
- `AreaConnectivityResponse` - 区域连通性响应
- `AssociatedFeature` - 关联特征
- `Attribution` - 归属信息
- `ClientCapabilities` - 客户端能力
- `CursorOverlayFormat` - 光标覆盖格式
- `DateTime` - 日期时间
- `Description` - 描述
- `Elevation` - 海拔
- `FreeformAnnotation` - 自由形式注释
- `Geometry` - 几何形状
- `ImageAttributes` - 图像属性
- `ImageFormatRestrictions` - 图像格式限制
- `ImageKey` - 图像键
- `ImageSize` - 图像大小
- `LatLng` - 经纬度
- `LatLngRectangle` - 经纬度矩形
- `LocationInfo` - 位置信息
- `MetadataQuery` - 元数据查询
- `MetadataRequest` - 元数据请求
- `MetadataResponse` - 元数据响应
- `MetadataResponseSpecification` - 元数据响应规范
- `NamedObject` - 命名对象
- `NavigationChannel` - 导航通道
- `NavigationChannelKey` - 导航通道键
- `NeighborTarget` - 邻居目标
- `NormalizedPixelPoint` - 标准化像素点
- `Overlay` - 覆盖层
- `Overlays` - 覆盖层集合
- `PanoramaParameters` - 全景参数
- `PhotoByLatLngQuery` - 按经纬度查询照片
- `PhotoFilterOptions` - 照片过滤选项
- `PhotoMetadata` - 照片元数据
- `PhotoQueryOptions` - 照片查询选项
- `PhotoThumbnailOptions` - 照片缩略图选项
- `ProductSpecialCaseOptions` - 产品特殊情况选项
- `RenderInfo` - 渲染信息
- `RenderStrategy` - 渲染策略
- `RequestContext` - 请求上下文
- `ResponseStatus` - 响应状态
- `Rotation` - 旋转
- `RouteAnnotation` - 路线注释
- `SingleAttribution` - 单一归属
- `SingleImageSearchRequest` - 单一图像搜索请求
- `SingleImageSearchResponse` - 单一图像搜索响应
- `SingleImageTile` - 单一图像瓦片
- `TactileUseCase` - 触觉用例
- `Takedown` - 下架
- `Target` - 目标
- `TargetOverlayFormat` - 目标覆盖格式
- `TargetTable` - 目标表
- `ThumbnailInfo` - 缩略图信息
- `ThumbnailOptions` - 缩略图选项
- `TileInfo` - 瓦片信息
- `TimeTarget` - 时间目标
- `VerticalTarget` - 垂直目标

### maps_paint_client.* (地图绘制客户端)

- `AbsoluteLabelPosition` - 绝对标签位置
- `AbsolutePointPosition` - 绝对点位置
- `AreaRenderOp` - 区域渲染操作
- `AreaRenderOpGroup` - 区域渲染操作组
- `AreaStyle` - 区域样式
- `ClientVectorTile` - 客户端矢量瓦片
- `CompactKeyZoom` - 紧凑键缩放
- `CompactMultiZoomStyle` - 紧凑多缩放样式
- `CompactMultiZoomStyleTable` - 紧凑多缩放样式表
- `ExtrudedArea` - 挤出区域
- `FontStyle` - 字体样式
- `IconStyle` - 图标样式
- `InteractivityMetadata` - 交互元数据
- `KeyZoom` - 键缩放
- `LabelElement` - 标签元素
- `LabelGroup` - 标签组
- `LabelRenderOp` - 标签渲染操作
- `LabelRenderOpGroup` - 标签渲染操作组
- `LabelSpriteMap` - 标签精灵贴图
- `LabelStyle` - 标签样式
- `LayerEpoch` - 图层纪元
- `LineRenderOp` - 线条渲染操作
- `LineRenderOpGroup` - 线条渲染操作组
- `LineStyle` - 线条样式
- `MultiZoomStyle` - 多缩放样式
- `MultiZoomStyleTable` - 多缩放样式表
- `PolyPolygon` - 多边形
- `PolylineLabelPosition` - 折线标签位置
- `Provider` - 提供者
- `ProviderTable` - 提供者表
- `RasterRenderOp` - 栅格渲染操作
- `RasterRenderOpGroup` - 栅格渲染操作组
- `RasterStyle` - 栅格样式
- `ShaderOpStyle` - 着色器操作样式
- `ShaderRenderOp` - 着色器渲染操作
- `ShaderRenderOpGroup` - 着色器渲染操作组
- `StripifiedMesh` - 条带化网格
- `StrokeStyle` - 描边样式
- `TextBoxStyle` - 文本框样式
- `TileOptions` - 瓦片选项
- `VolumeRenderOp` - 体积渲染操作
- `VolumeRenderOpGroup` - 体积渲染操作组
- `VolumeStyle` - 体积样式
- `WaterGradientStyle` - 水渐变样式
- `WaterShaderData` - 水着色器数据

### maps_paint.* (地图绘制)

- `EpochResources` - 纪元资源
- `LatLngRegionRectangle` - 经纬度区域矩形
- `LayerDescription` - 图层描述
- `PaintParameterResponse` - 绘制参数响应
- `PaintRequest` - 绘制请求
- `PaintStyleOptions` - 绘制样式选项
- `PaintTemplateResponse` - 绘制模板响应
- `PaintedRegion` - 绘制区域
- `PaintedRegionList` - 绘制区域列表
- `PipeMetadata` - 管道元数据
- `RegionDescription` - 区域描述
- `StyleTableMapping` - 样式表映射
- `StylerDescription` - 样式器描述
- `VectorOptions` - 矢量选项

### geo_globetrotter_proto_rocktree.* (Globetrotter Rocktree)

- `AcquisitionDate` - 采集日期
- `AcquisitionDateRange` - 采集日期范围
- `BulkMetadata` - 批量元数据
- `Copyright` - 版权
- `Copyrights` - 版权集合
- `DatedCopyright` - 带日期的版权
- `DatedNode` - 带日期的节点
- `Mesh` - 网格
- `NodeData` - 节点数据
- `NodeKey` - 节点键
- `NodeMetadata` - 节点元数据
- `PlanetoidMetadata` - 行星体元数据
- `Texture` - 纹理

### geo_photo.* (地理照片)

- `ImageryCoverageMetadata` - 图像覆盖元数据
- `RankingOptions` - 排名选项

### homescreen.* (主屏幕)

- `ActiveProjectsList` - 活动项目列表
- `DriveSortDirection` - Drive 排序方向
- `DriveSortKey` - Drive 排序键
- `HasSeenImportFileToProjectMenuItem` - 是否已查看导入文件到项目菜单项
- `KmlSortAttribute` - KML 排序属性
- `KmlSortDirection` - KML 排序方向

### other namespaces (其他命名空间)

#### apptheme.*
- `DarkMode` - 深色模式
- `HighContrast` - 高对比度

#### cloud_logging.*
- `REDACT` - 编辑标记

#### datacatalog.*
- `HasSeenDataCatalog` - 是否已查看数据目录

#### datapol.*
- `ST_ACCOUNT_CREDENTIAL` - 账户凭证
- `ST_ARES_ID` - ARES ID
- `ST_PAYMENTS_PCI_SAD` - 支付 PCI SAD
- `ST_SECURITY_KEY` - 安全密钥
- `ST_SECURITY_MATERIAL` - 安全材料
- `ST_SPII_ID` - SPII ID

#### delve.*
- `HasSeenDelve` - 是否已查看 Delve
- `HasSeenSiteSelection` - 是否已查看站点选择

#### design.*
- `HasSeenDesignOnboardingInfoPanel` - 是否已查看设计入门信息面板

#### geostore.*
- `PointProto` - 点原型
- `RectProto` - 矩形原型

#### jsproto.*
- `Type` - 类型

#### maps_api.*
- `MapsApiMetadataProto` - Maps API 元数据原型

#### maps_roadtraffic.*
- `IncidentMetadata` - 事件元数据

#### maps_util.*
- `TileCoordinateProto` - 瓦片坐标原型

#### network.*
- `KnownThirdPartyDomains` - 已知第三方域名

#### sponge_perf.*
- `Aggregation` - 聚合
- `ConfigurationValue` - 配置值
- `Metric` - 指标
- `PerformanceData` - 性能数据
- `Sample` - 样本

#### time.*
- `AltitueRecommendationToastCount` - 海拔推荐吐司计数

#### usersettings.*
- `GeographicRegion` - 地理区域
- `GeographicScales` - 地理缩放
- `Industries` - 行业
- `PrimaryUse` - 主要用途

## 消息分类

### 输入事件相关
- `earth.InputEvent` - 主要输入事件
- `earth.InputEventState` - 输入事件状态
- `earth.KeyboardEvent` - 键盘事件
- `earth.PointerEvent` - 指针事件
- `earth.TouchPointer` - 触摸指针

### 相机和视图
- `earth.Camera` - 相机配置
- `earth.Location` - 位置信息
- `earth.ResizeEvent` - 调整大小事件

### 渲染相关
- `earth_knowledge.RenderableEntity` - 可渲染实体
- `maps_paint_client.*` - 地图绘制相关（68个消息）
- `geo_globetrotter_proto_rocktree.*` - 3D 渲染相关（13个消息）

### 照片和图像
- `earth_photos.ThumbnailImage` - 缩略图
- `geo_photo_service.*` - 地理照片服务（68个消息）
- `geo_photo.*` - 地理照片（2个消息）

### 配置和设置
- `earth.LocalizedStrings` - 本地化字符串
- `usersettings.*` - 用户设置（4个消息）
- `apptheme.*` - 应用主题（2个消息）

### 数据获取
- `earth.Arguments` - 参数
- `earth.ExperimentFlag` - 实验标志

## 重要消息使用说明

### earth.InputEvent

这是唯一需要手动编码和发送的消息类型，用于处理鼠标和键盘输入。

详见 `WASM_FULL_ANALYSIS.md` 第 9-10 节。

### 其他消息

其他消息类型主要用于：
- WASM 内部通信
- 服务配置
- 日志上报
- 数据存储

这些消息通常不需要手动编码和发送。

## 文件结构

```
earthplugin_web.wasm (20MB)
├── Protobuf 消息定义 (229个)
├── WASM 代码
├── 字符串常量
└── 其他数据
```

## 完整消息列表（按字母顺序）

完整列表见上，总计 229 个消息类型分布在 33 个命名空间中。


# Earth WASM Protobuf 消息完整文档

**生成时间**: 2025-10-22T10:13:41.602Z
**总命名空间**: 455
**总消息数**: 3789

---

## 📋 目录

1. [核心消息 (earth.*)](#核心消息)
2. [Google 标准 (google.*)](#google-标准)
3. [地图服务 (maps.*)](#地图服务)
4. [地理数据 (geo.*)](#地理数据)
5. [功能模块 (earth.feature.*)](#功能模块)
6. [质量控制 (quality.*)](#质量控制)
7. [配置管理 (config.*)](#配置管理)
8. [其他模块](#其他模块)

---


## Core

**命名空间数**: 142

### earth

- **消息数量**: 13
- **用途**: 功能模块
- **关键消息**: Arguments, Camera, ExperimentFlag, ExperimentFlagR, InputEvent, InputEventState, KeyboardEvent, LocalizedStrings, LocalizedStringsState, Location
  - ... 还有 3 个消息

### earth.account

- **消息数量**: 13
- **用途**: 功能模块
- **关键消息**: AccountViewModelCommand, AccountViewModelState, AuthInfoRequest, AuthInfoResponse, HttpRequest, HttpResponse, LaunchUrl, MakeHttpRequest, PlatformAccountInfo, PromptUserToSignIn
  - ... 还有 3 个消息

### earth.addbuildingtypes

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: AddBuildingInput, AddBuildingInputbuilding_template_idbuilding_template_name, AddBuildingTypesViewModelCommand, AddBuildingTypesViewModelState, LogSimpleEvent

### earth.approot

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: AppRootViewModelCommand, AppRootViewModelState, OnFileDrop, OnFileDropname

### earth.apptheme

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: AppThemeViewModelCommand, AppThemeViewModelState

### earth.areafilter

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: AreaFilterViewModelCommand, AreaFilterViewModelState, AreaFilterViewModelStatelayer_namemobile_see_plans_urllayer_logging_id

### earth.balloon

- **消息数量**: 40
- **用途**: 功能模块
- **关键消息**: BalloonContent, BalloonViewModelCommand, BalloonViewModelState, CarouselImage, CarouselImages, HandleEarthDeepLink, HandleEarthDeepLinkurl, HandleKmlLink, HandleKmlLinkhrefbase_url, LayerOpacity
  - ... 还有 30 个消息

### earth.bottompanel

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: BottomPanelViewModelCommand, BottomPanelViewModelState

### earth.bottomsheet

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: BottomSheetViewModelCommand, BottomSheetViewModelState

### earth.boundaryselection

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: BoundarySelectionViewModelCommand, BoundarySelectionViewModelState, SelectBoundary, SelectBoundaryfeature_id

### earth.buildingeditor

- **消息数量**: 21
- **用途**: 功能模块
- **关键消息**: AddFloorGroup, AddFloorGroupfloor_group_id, AdvancedSettings, BuildingConfiguration, BuildingEditorViewModelCommand, BuildingEditorViewModelState, BuildingUserInputs, FloorGroup, FloorGroupValidationErrorMessages, LogSimpleEvent
  - ... 还有 11 个消息

### earth.buildingtemplates

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: BuildingTemplateFarRangeInfo, BuildingTemplateFarRangeInfoR, BuildingTemplateInfo, FarRangeCategoryR

### earth.carddock

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: CardDockViewModelCommand, CardDockViewModelState

### earth.collapsedwidgets

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: CollapsedWidgetsViewModelCommand, CollapsedWidgetsViewModelState

### earth.compass

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: CompassViewModelCommand, CompassViewModelState, SetHeading, SetTilt

### earth.config

- **消息数量**: 9
- **用途**: 配置
- **关键消息**: BaseLayerStyle, ConfigRequestFailed, ConfigViewModelCommand, ConfigViewModelState, LoadCachedConfigSuccess, PaintFeLayer, RasterLayer, RetryConfigRequest, StoreConfigInCache

### earth.contouranalysis

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: ContourAnalysisViewModelCommand, ContourAnalysisViewModelState, ContourAnalysisViewModelStatemobile_see_plans_urlhelp_url, SetContourInterval

### earth.copydesigninputsdialog

- **消息数量**: 2
- **用途**: 输入事件
- **关键消息**: CopyDesignInputsDialogViewModelCommand, CopyDesignInputsDialogViewModelState

### earth.core

- **消息数量**: 15
- **用途**: 功能模块
- **关键消息**: AddCardButtonData, CardButtonData, CardData, CardDataidtitleimage_thumbnail_urlimage_labeldescription, CardGridData, CardIconButtonData, CardTagData, DisplayMessages, ErrorTooltipData, LocalizedMessage
  - ... 还有 5 个消息

### earth.core.apptheme

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AppTheme

### earth.core.drawingmode

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DrawingModeR

### earth.core.lightbox

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: LightboxData, LightboxDataR, LightboxMedia, LightboxMediaR, MediaAttribution, MediaAttributionR, YoutubeVideo, YoutubeVideoH

### earth.core.projecttools

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ProjectToolsState

### earth.core.shortcuts

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ShortcutMessage

### earth.core.viewgroup

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: View, ViewGroup, ViewGroupR, ViewIdR, ViewR

### earth.createlinkdialog

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: Confirm, CreateLinkDialogViewModelCommand, CreateLinkDialogViewModelState, FeatureLink, LinkTarget, LinkTargets, Result, UrlLink

### earth.datacatalogdialog

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: CloseDataCatalogDialog, DataCatalogDialogViewModelCommand, DataCatalogDialogViewModelState, DataCatalogDialogViewModelStatemobile_see_plans_url, OnLayerButtonPressed, OnLayerButtonPressedlayer_id, OpenLayerMetadata, OpenLayerMetadatalayer_id

### earth.datatable

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: ColumnParams, DataTableViewModelCommand, DataTableViewModelState, RowContents, TableValue

### earth.deeplink

- **消息数量**: 35
- **用途**: 功能模块
- **关键消息**: BasemapStyleData, BasemapStyleDataR, DesignData, DesignDataR, DocumentData, DocumentDataR, DriveAction, DriveActionR, DriveCreateAction, DriveCreateActionH
  - ... 还有 25 个消息

### earth.deletedocumentdialog

- **消息数量**: 2
- **用途**: 文档处理
- **关键消息**: DeleteDocumentDialogViewModelCommand, DeleteDocumentDialogViewModelState

### earth.delve

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: DelveConfig, DelveViewModelCommand, DelveViewModelState, LaunchDelveUrlEvent, ParcelAnalysis

### earth.design

- **消息数量**: 17
- **用途**: 功能模块
- **关键消息**: DesignMapResult, DesignResult, DesignResultR, DownloadDesignFileRequest, DownloadDesignFileResponse, DownloadDesignFileResponseH, Filter, FilterR, NewBuildToplineMetrics, NewBuildToplineMetricsH
  - ... 还有 7 个消息

### earth.designbuiltentity

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DesignBuiltEntityViewModelCommand, DesignBuiltEntityViewModelState

### earth.designdetails

- **消息数量**: 50
- **用途**: 功能模块
- **关键消息**: AreaMetrics, AreaMetricsR, DesignDetailsViewModelCommand, DesignDetailsViewModelState, DesignStatsMetrics, DesignStatsMetricsR, DownloadDesignFile, EmissionsSummaryMetrics, EmissionsSummaryMetricsR, ExportDesignFile
  - ... 还有 40 个消息

### earth.designeditor

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DesignEditorViewModelCommand, DesignEditorViewModelState

### earth.designexport

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PendingExport

### earth.designinput

- **消息数量**: 3
- **用途**: 输入事件
- **关键消息**: DesignGenerationResult, GenerateDesignsRequestStateR, MaxSiteAreaStateR

### earth.designinputmodechooser

- **消息数量**: 2
- **用途**: 输入事件
- **关键消息**: DesignInputModeChooserViewModelCommand, DesignInputModeChooserViewModelState

### earth.designinputvalidation

- **消息数量**: 10
- **用途**: 输入事件
- **关键消息**: DesignValidation, FieldValidRange, InputCategoryValidationErrors, ProgramErrorContext, UseTypeErrorContext, ValidInputRanges, ValidRange, ValidationError, ZoningErrorContext, ZoningInputRanges

### earth.designviewer

- **消息数量**: 18
- **用途**: 功能模块
- **关键消息**: DesignViewerViewModelCommand, DesignViewerViewModelState, DownloadDesignFile, ExportDesignFile, ExportDesignFiledesign_iddesign_name, OpenDesignDetails, OpenDesignDetailsdesign_id, OpenDesignEditor, OpenDesignEditordesign_id, RequestDesigns
  - ... 还有 8 个消息

### earth.document

- **消息数量**: 22
- **用途**: 文档处理
- **关键消息**: CapabilityR, DocumentKindR, DocumentMetadata, DocumentMetadataR, DocumentNamespaceR, DocumentStorageMetadata, DocumentUmsMetadata, DocumentUmsMetadataR, EarthBalloonTemplate, EarthBalloonTemplateList
  - ... 还有 12 个消息

### earth.document.proto

- **消息数量**: 3
- **用途**: 文档处理
- **关键消息**: FeatureKey, FeatureKeyR, FeatureKeykey

### earth.document.protos

- **消息数量**: 407
- **用途**: 文档处理
- **关键消息**: AccessInfo, AccessInfoR, AddColumn, AddColumnH, AddFeature, AddFeatureH, AddFeatureMedia, AddFeatureMediaH, AddressFailedGeocoding, AddressFailedGeocodingH
  - ... 还有 397 个消息

### earth.documentexport

- **消息数量**: 5
- **用途**: 文档处理
- **关键消息**: DocumentExportData, DocumentExportViewModelCommand, DocumentExportViewModelState, ExportedKml, ExportedKmlsuggested_filenamekml_content

### earth.documentimport

- **消息数量**: 25
- **用途**: 文档处理
- **关键消息**: ConfirmImportDriveDocument, ConfirmImportDriveDocumentmap_idresource_keymime_typenameencoded_url, ConfirmImportLocalDocument, ConfirmImportLocalDocumentencoded_urlname, DisplayNotification, DocumentImportViewModelCommand, DocumentImportViewModelState, DriveFileMetadata, ImportFailures, ImportKmlFromClipboardToDriveProject
  - ... 还有 15 个消息

### earth.documentpicker

- **消息数量**: 4
- **用途**: 文档处理
- **关键消息**: CreateDriveProject, DocumentPickerViewModelCommand, DocumentPickerViewModelState, FocusProject

### earth.documentsharing

- **消息数量**: 4
- **用途**: 文档处理
- **关键消息**: DocumentSharingViewModelCommand, DocumentSharingViewModelState, RenameDocument, RenameDocumentnew_title

### earth.documentview

- **消息数量**: 17
- **用途**: 文档处理
- **关键消息**: CancelImport, CommitPendingTouchSelection, ConfirmCopyDocument, ConfirmCopyDocumentcopy_title, DocumentNotification, DocumentViewViewModelCommand, DocumentViewViewModelState, OpenImportErrorGuide, PasteFeatureFromClipboard, PasteFeatureFromClipboardfeature_kml
  - ... 还有 7 个消息

### earth.drawingtool

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: DrawingToolViewModelCommand, DrawingToolViewModelState, EnterDrawingToolInMode, SetCanEditOutsideEditor, SetClampAltitudeOnDrag, SetUseTouchBasedDrawing

### earth.droppedpin

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DroppedPinViewModelCommand, DroppedPinViewModelState

### earth.earthmate

- **消息数量**: 27
- **用途**: 功能模块
- **关键消息**: Chat, ChatMessage, ChatZeroState, Conversation, CreateMapProject, EarthMateErrorResponse, EarthMateViewModelCommand, EarthMateViewModelState, InteractionState, OnboardingDialogState
  - ... 还有 17 个消息

### earth.earthrender

- **消息数量**: 25
- **用途**: 功能模块
- **关键消息**: AddLayerFeatureToProject, AddLayerFeatureToProjectfeature_idlayer_idfeature_name, AddPlacemarkAt, CopyStyle, DeleteFeature, EarthRenderViewModelCommand, EarthRenderViewModelState, EditFeature, EnterStreetViewAtLocation, EnterStreetViewAtPixel
  - ... 还有 15 个消息

### earth.experiments

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: AllowFlagOverrides, ExperimentFlags, ExperimentFlagsR, ExperimentIds, ExperimentsViewModelCommand, ExperimentsViewModelState, OverrideFlagValues, SetPhenotypeFlags, SetPhenotypeServerToken, SetPhenotypeServerTokentoken

### earth.featuretree

- **消息数量**: 39
- **用途**: 功能管理
- **关键消息**: AddToPendingTouchSelection, AdjustOpacity, BringToFront, CollapseParent, CopyFeatureToClipboard, CopyStyle, Delete, EditProperties, EnterTouchSelectionMode, FeatureTreeViewModelCommand
  - ... 还有 29 个消息

### earth.featureupdater

- **消息数量**: 96
- **用途**: 功能管理
- **关键消息**: AltitudeModeR, Attribute, AttributeR, AttributeSpec, AttributeSpecR, AttributeSpecSplices, AttributeTypeR, AttributeUpdate, AttributeUpdateR, BalloonStyle
  - ... 还有 86 个消息

### earth.feedback

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: FeedbackViewModelCommand, FeedbackViewModelState, ShowDialogEvent

### earth.filters

- **消息数量**: 12
- **用途**: 功能模块
- **关键消息**: AttributeFilterData, AttributeFilterDatakeylocalized_name, CategoricalFilterData, DataLayerFilters, DataLayerFiltersfilters, DoubleRange, FilterOption, FilterOptionvalue_idlocalized_name, IntRange, Range
  - ... 还有 2 个消息

### earth.gcpprojectbilling

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: GcpProjectBillingViewModelCommand, GcpProjectBillingViewModelState, LeaveSelectedGcpProject, OpenUpgradeDialog, RefreshLicenses, SelectGcpProject, SelectGcpProjectgcp_project_id

### earth.hats

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: HatsViewModelCommand, HatsViewModelState, PresentSurveyFailed, PresentSurveyFailedtrigger_id, PresentSurveySucceeded, PresentSurveySucceededtrigger_id, SurveyTriggerEvent

### earth.homescreen

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: AddDocumentWithKmlContent, AddDocumentWithKmlContentname, AddEmptyDriveDesignDocument, AddEmptyDriveDocument, AddEmptyLocalDocument, DismissHomescreen, HomescreenViewModelCommand, HomescreenViewModelState, RequestOpenDriveDocumentDialog, RequestOpenLocalFileDialog
  - ... 还有 1 个消息

### earth.hoverbutton

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: HoverButtonViewModelCommand, HoverButtonViewModelState

### earth.industryselector

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: DismissBanner, IndustrySelectorSurveyInputs, IndustrySelectorSurveyQuestion, IndustrySelectorSurveyQuestions, IndustrySelectorViewModelCommand, IndustrySelectorViewModelState, ShowBanner, ShowSurveyDialog, UpdateSurveyInputs

### earth.info

- **消息数量**: 19
- **用途**: 功能模块
- **关键消息**: AggregateStats, BoundingBox2dValue, CardActionSelection, CardActions, CardViewModelCommand, CardViewModelState, FeatureInfo, FlyToKnowledgeCard, GetStaticMapsUrl, GetStaticMapsUrlkey
  - ... 还有 9 个消息

### earth.inspector

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: InspectorViewModelCommand, InspectorViewModelState

### earth.killswitch

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: KillSwitchViewModelCommand, KillSwitchViewModelState

### earth.kmltree

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: NodeUpdate, RowUpdate, Selection, Updates

### earth.layerdatatable

- **消息数量**: 8
- **用途**: 图层管理
- **关键消息**: LayerDataTableColumn, LayerDataTableColumnattribute_namelocalized_name, LayerDataTableRow, LayerDataTableRowfeature_id, LayerDataTableViewModelCommand, LayerDataTableViewModelState, OnRowInteracted, OnRowInteractedfeature_id

### earth.layerdetails

- **消息数量**: 37
- **用途**: 图层管理
- **关键消息**: AddFilter, AddFilterattribute_key, AttributeDrivenColor, BringLayerToFront, DeleteFilter, DeleteFilterattribute_key, DeleteLayer, EditLayer, FilterState, LabelStyle
  - ... 还有 27 个消息

### earth.layers

- **消息数量**: 32
- **用途**: 图层管理
- **关键消息**: BaseLayer, BaseLayerStyleInfo, BaseLayerStyles, BaseLayerToastEvent, BaseLayerViewModelCommand, BaseLayerViewModelState, BaseLayerVisibilities, BaseLayers, BasemapStyle, BasemapStyleInfo
  - ... 还有 22 个消息

### earth.leftpanel

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: LeftPanelViewModelCommand, LeftPanelViewModelState

### earth.legend

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: Categorical, ChoroplethContinuous, ChoroplethDiscrete, HSVColor, Item, Legend, LegendLayer, LegendSection, LegendViewModelCommand, LegendViewModelState
  - ... 还有 1 个消息

### earth.lightbox

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: LightboxViewModelCommand, LightboxViewModelState, SetMaxImageSize, ShowLightboxImage

### earth.localfilesystem

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: FileMetadata

### earth.logging

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: AnonymousLoggingContext, AnonymousLoggingContextgeographic_regions, LogDeeplink, LogDeeplinkpathquery, LogStartupTimeSec, LoggingCommandInitAppInfo, LoggingContext, LoggingEvent, LoggingViewModelCommand, LoggingViewModelState

### earth.maintoolbar

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: MainToolbarViewModelCommand, MainToolbarViewModelState, SetFocusedDocumentTitle, SetFocusedDocumentTitletitle, ToggleSiteSelection

### earth.mapspaceediting

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: MapSpaceEditingViewModelCommand, MapSpaceEditingViewModelState, Model, UpdateFeatureProperties

### earth.math

- **消息数量**: 14
- **用途**: 功能模块
- **关键消息**: BoundingBox2d, BoundingBox3d, BoundingBox3dR, LatLng, LatLngAlt, LatLngR, Matrix4, Orientation, OrientationR, RgbColor
  - ... 还有 4 个消息

### earth.measuretool

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: MeasureToolViewModelCommand, MeasureToolViewModelState, SetUseTouchBasedDrawing

### earth.menubar

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: AboutEarthDialogRequest, AdvanceFakeFileImport, CompleteFakeFileImport, CompleteFakeFileImportWithFailures, FailFakeFileImport, FakeFileImport, MenuActionMessage, MenuBarViewModelCommand, MenuBarViewModelState, MenuItemPressed
  - ... 还有 1 个消息

### earth.modelcontext

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: Context, Contexturinametitledescriptionmime_typetext, Resource, Resourceuriuri_templateparametersnametitledescription, Schema, SchemaR, Schemanametitledescriptiontext

### earth.mylocation

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: MyLocationViewModelCommand, MyLocationViewModelState, Update

### earth.navigationcontrols

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: NavigationControlsViewModelCommand, NavigationControlsViewModelState

### earth.networkmonitor

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: NetworkMonitorViewModelCommand, NetworkMonitorViewModelState, ToastContents

### earth.newbuilddesigninput

- **消息数量**: 10
- **用途**: 输入事件
- **关键消息**: InitiateGenerateDesigns, LicenseConfig, LogSimpleEvent, NewBuildDesignInputViewModelCommand, NewBuildDesignInputViewModelState, NewBuildUserInputs, ResetParcelZoning, ResetParcelZoningparcel_id, TopLevelErrorMessage, UpdateUserInputs

### earth.onboarding

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: OnboardingViewModelCommand, OnboardingViewModelState

### earth.pinnedprojects

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: PinnedProjectsViewModelCommand, PinnedProjectsViewModelState, StageDocumentPin, StageDocumentUnpin

### earth.playmode

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: PlayModeViewModelCommand, PlayModeViewModelState, ShowFeatureAtIndex

### earth.polygoncreator

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: PolygonCreatorViewModelCommand, PolygonCreatorViewModelState

### earth.projectslist

- **消息数量**: 47
- **用途**: 功能模块
- **关键消息**: AddDriveDocumentWithUmsMapId, AddDriveDocumentWithUmsMapIdmap_idresource_keydocument_mime_typename, AddEmptyDriveDesignDocument, AddEmptyDriveDocument, AddEmptyLocalDocument, AddLocalDocumentWithKmlContent, AddLocalDocumentWithKmlContentname, AddLocalDocumentWithUrl, AddLocalDocumentWithUrlurlname, ClearLastModifiedTimeFilter
  - ... 还有 37 个消息

### earth.promotion

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: IncrementNumTimesSeen, IncrementNumTimesSeensettings_key_path, PromotionViewModelCommand, PromotionViewModelState, RegisterSettingsKeyPath, RegisterSettingsKeyPathsettings_key_path, SetIsDismissed, SetIsDismissedsettings_key_path, UnregisterSettingsKeyPath, UnregisterSettingsKeyPathsettings_key_path

### earth.propertyeditor

- **消息数量**: 21
- **用途**: 功能模块
- **关键消息**: AddNewAttribute, AddNewAttributename, AllowedTemplateIds, BackToView, BulkEditor, CloseEditor, DeleteAttributeFromSchema, DeleteAttributeFromSchemaid, InsertLinkInRichTextEditor, LegacyPerformUndo
  - ... 还有 11 个消息

### earth.proto

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: KmlFeatureKey, KmlFeatureKeykey

### earth.requestaccess

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: RequestAccessViewModelCommand, RequestAccessViewModelState, RequestAccessViewModelStateproject_titlelearn_more_urlemail_message, UpdateEmailMessage, UpdateEmailMessagemessage

### earth.screenshotsharing

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: ScreenshotSharingViewModelCommand, ScreenshotSharingViewModelState

### earth.search

- **消息数量**: 13
- **用途**: 功能模块
- **关键消息**: FlyToResult, PerformGroupCommand, PerformResultCommand, RequestSearchResultGroupPage, RequestSearchResultGroupPagepage_token, SearchViewModelCommand, SearchViewModelState, SetEarthViewVisibleHeightPercentageDuringSearch, SetSearchState, SetSearchStatequery
  - ... 还有 3 个消息

### earth.settings

- **消息数量**: 22
- **用途**: 功能模块
- **关键消息**: BoolSetting, ClearValue, ClearValuekey_path, EnumSetting, GetValue, GetValuekey_pathdefault_value, InfoSetting, Init, MultiEnumSetting, RemoveSettingEvent
  - ... 还有 12 个消息

### earth.sharingpolicy

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SharingPolicyViewModelCommand, SharingPolicyViewModelState

### earth.shortcuts

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: ShortcutInvoked, ShortcutsViewModelCommand, ShortcutsViewModelState

### earth.siteselection

- **消息数量**: 12
- **用途**: 功能模块
- **关键消息**: AreaDescription, EditAreaPolygon, LayerConfig, LicenseConfig, Parcel, ParcelInfo, PendingAreaConfig, PendingAreaInfo, RemoveParcel, SiteSelectionResult
  - ... 还有 2 个消息

### earth.solardesigninput

- **消息数量**: 12
- **用途**: 输入事件
- **关键消息**: InitiateGenerateDesigns, LicenseConfig, LicenseConfigR, ParcelInput, ParcelInputR, SolarDesignInputViewModelCommand, SolarDesignInputViewModelState, SolarUserInputs, SolarUserInputsR, StartWithNewDraftRequestStateH
  - ... 还有 2 个消息

### earth.splashscreen

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SplashScreenViewModelCommand, SplashScreenViewModelState

### earth.state

- **消息数量**: 133
- **用途**: 状态管理
- **关键消息**: DataState, DataStateR, LatLonBox, LatLonBoxR, LayerFeatureAttribute, LayerFeatureAttributeR, LayerFeatureDetailsData, LayerFeatureDetailsDataH, NonRestorableAccountData, NonRestorableAccountDataR
  - ... 还有 123 个消息

### earth.state.derivedstate

- **消息数量**: 104
- **用途**: 状态管理
- **关键消息**: AddBuildingTypesDerivedState, AppRootDerivedState, AppThemeDerivedState, AreaFilterDerivedState, AreaFilterDerivedStatelayer_namelayer_logging_id, BackNavigationDerivedState, BalloonDerivedState, BasemapStyleState, BasemapStyleStateR, BottomSheetDerivedState
  - ... 还有 94 个消息

### earth.streetview

- **消息数量**: 20
- **用途**: 功能模块
- **关键消息**: CapturedStreetViewEvent, CollapseTimeline, EnterStreetView, ExpandTimeline, KeyboardEnterStreetView, LoadPanoThumbsEvent, NavigateToNeighborPano, PanoId, PanoTimeline, SeekNextTimelineDate
  - ... 还有 10 个消息

### earth.styleeditor

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: Icon, RecentIcons, StockIcon, StockIconCategory, StockIcons

### earth.system

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: SetMemoryUsageTargetMb, SetRenderSceneEnabled, SystemViewModelCommand, SystemViewModelState

### earth.time

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DateTime

### earth.timelapse

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: SetTimelapseFramerateMultiplier, TimelapseViewModelCommand, TimelapseViewModelState

### earth.timemachine

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: Date, DateState, DateStateMessageUpdate, SetDate, SetDateiso_date, TimeMachineViewModelCommand, TimeMachineViewModelState, UpdateDateState, Year, YearMessageUpdate

### earth.toast

- **消息数量**: 12
- **用途**: 功能模块
- **关键消息**: ToastInvalidKml, ToastProjectDuplicated, ToastProjectDuplicatedproject_title, ToastProjectMovedToTrash, ToastProjectRenamed, ToastProjectRenamedold_titlenew_title, ToastRequestAccessFailed, ToastRequestAccessSent, ToastSlideShowGenerated, ToastTooManyFeaturesForBulkEdit
  - ... 还有 2 个消息

### earth.toptoolbar

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: ActionItem, ToolbarTitle, ToolbarTitleWithAttribution, ToolbarTitleWithSubtitle, TopToolbarState, TopToolbarViewModelCommand, TopToolbarViewModelState, UserActionItem, UserActionTriggered

### earth.tour

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: Seek, State, TourViewModelCommand, TourViewModelState

### earth.unitconversion

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: AutoUnits, AvailableUnits, DefaultUnits, SetAreaUnit, SetDistanceUnit, SetSlopeUnit, Unit, UnitCategories, UnitConversionViewModelCommand, UnitConversionViewModelState
  - ... 还有 1 个消息

### earth.urlsharing

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: ConfirmDialog, SetAdditionalUrlParameters, SetAdditionalUrlParametersparameters, ShareInfo, UrlSharingViewModelCommand, UrlSharingViewModelState

### earth.usererrors

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: Action, TakeAction, UserErrorItem, UserErrorsViewModelCommand, UserErrorsViewModelState

### earth.viewstatus

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: AltitudeWithUnits, ImageryAcquisitionDateRange, LoadProgress, PointerCoordinates, ScaleBarData, SetMaxScaleBarUiLength, ViewStatus, ViewStatusViewModelCommand, ViewStatusViewModelState

### earth.voyagerturndown

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: VoyagerTurndownViewModelCommand, VoyagerTurndownViewModelState

### earth.zoombuttons

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: ZoomButtonsViewModelCommand, ZoomButtonsViewModelState

### earth_knowledge

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RenderableEntity

### earth_photos

- **消息数量**: 1
- **用途**: 照片服务
- **关键消息**: ThumbnailImage

### earthfeed

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: EarthFeedCategoryR, EarthFeedItemH, EarthFeedItemR, EarthFeedR, EarthLayerIdR, ImageR, ItemActionR, SpecialFeatureR

### earthmate

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: HasSeenEarthMate

### geo.earth.app

- **消息数量**: 16
- **用途**: 功能模块
- **关键消息**: BillingUpgradeDialogSourceViewR, DataCatalogDialogSourceViewR, DeeplinkEvent, DeeplinkEventR, EarthEvent, EarthFeedEventR, ExperimentFlagsB, ExplorePromotionDialogVariantR, IndustrySelectorResponseEventR, MirthStatsEvent
  - ... 还有 6 个消息

### geo.earth.proto

- **消息数量**: 70
- **用途**: 功能模块
- **关键消息**: BaseLayerStyleConfig, BootstrapClientConfig, ClearSearchHistory, ClearSearchHistoryB, Command, CommandR, CommandSourceB, Commands, CompileTimeConfig, CreateCloudProject
  - ... 还有 60 个消息

### geo.earth.proto.earth_mate

- **消息数量**: 16
- **用途**: 功能模块
- **关键消息**: CreationContext, EarthMateAppContext, EarthMateAreaDescriptionRequest, EarthMateAreaDescriptionResponse, EarthMateAttribution, EarthMateChatContext, EarthMateChatHistory, EarthMateErrorDetail, EarthMateQueryRequest, EarthMateQueryResponse
  - ... 还有 6 个消息

### geo_earth_proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: StorageR

### geo_sidewalklabs_delve.earth

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: CreateStudyRequest, Geometry, VertexList2D

### google.internal.earth.v1

- **消息数量**: 57
- **用途**: 功能模块
- **关键消息**: AppliedStyleRules, AppliedStyleRulesR, AttributeValue, AttributeValueR, CategoricalFilterSet, CategoricalFilterSetH, CategoricalStyleMethod, CategoricalStyleMethodR, ClientMetadata, ClientMetadataB
  - ... 还有 47 个消息

### google.internal.earth.v1.billing

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: License, ListLicensesResponse

### google.internal.earth.v1.builtenv

- **消息数量**: 102
- **用途**: 功能模块
- **关键消息**: AddFloorsEditH, AdjustBlockProgramEditH, BatchGetUserQuotasResponse, BuildingConfiguration, BuildingConfigurationR, BuildingInput, BuildingInputR, BuildingTemplate, BuildingTemplateR, BuildingTemplateTypeR
  - ... 还有 92 个消息

### google.internal.earth.v1.config

- **消息数量**: 47
- **用途**: 配置
- **关键消息**: AbsoluteUrlTemplate, AbsoluteUrlTemplateR, AnimatedCloudsConfigB, BillingConfig, BillingConfigR, BuiltenvConfig, BuiltenvConfigR, CelestialBodiesConfig, CelestialBodiesConfigR, CelestialBodyR
  - ... 还有 37 个消息

### google.internal.earth.v1.featureflags

- **消息数量**: 1
- **用途**: 功能管理
- **关键消息**: GetFeatureFlagsResponse

### google.internal.earth.v1.knowledge

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GetKnowledgeCardResponse

### google.internal.earth.v1.layers

- **消息数量**: 34
- **用途**: 图层管理
- **关键消息**: CreateOnDemandLayerRequest, CreateOnDemandLayerResponse, DataLayerViewR, ElevationContourInputs, ElevationContourInputsH, Feature, FeatureAttributeValue, FeatureAttributeValueR, FeatureR, GetDataLayerRequest
  - ... 还有 24 个消息

### google.internal.earth.v1.photos

- **消息数量**: 2
- **用途**: 照片服务
- **关键消息**: GetPhotosForPointResponse, GetThumbnailsForViewportResponse

### google.internal.earth.v1.quota

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: GetUserAssetQuotaRequest, GetUserAssetQuotaResponse, UserAssetQuota

### google.internal.earth.v1.search

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: HighlightableText, Result, ResultGraphics, ResultGroupDisplayOptions, ResultGroupLink, SearchResponse, SearchResultGroup, SuggestResponse, SuggestResultGroup

### google.internal.earth.v1.survey_metadata

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SurveyEvent, SurveyMetadata

### google.internal.earth.v1.terrain

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: BatchGetElevationsByPointRequest, BatchGetElevationsByPointResponse

### google.internal.earth.v1.user

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GetUserResponse

### google.internal.earth.v1.user_metadata

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: UserMetadata, UserMetadataUpdate

### google.internal.earth.v1.user_settings

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: EarthUserCountryCodes, EarthUserGeographicScales, EarthUserIndustries, UserSettings


## Google

**命名空间数**: 17

### google.api

- **消息数量**: 34
- **用途**: 功能模块
- **关键消息**: ApiInclusionB, AuthorizationRuleB, AuthorizationRuleR, BatchingConfigProtoB, BatchingDescriptorProtoR, BatchingSettingsProtoR, ClientLibraryDestinationB, ClientLibraryOrganizationB, ClientLibrarySettingsB, CommonLanguageSettingsB
  - ... 还有 24 个消息

### google.internal.earth.v1

- **消息数量**: 57
- **用途**: 功能模块
- **关键消息**: AppliedStyleRules, AppliedStyleRulesR, AttributeValue, AttributeValueR, CategoricalFilterSet, CategoricalFilterSetH, CategoricalStyleMethod, CategoricalStyleMethodR, ClientMetadata, ClientMetadataB
  - ... 还有 47 个消息

### google.internal.earth.v1.billing

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: License, ListLicensesResponse

### google.internal.earth.v1.builtenv

- **消息数量**: 102
- **用途**: 功能模块
- **关键消息**: AddFloorsEditH, AdjustBlockProgramEditH, BatchGetUserQuotasResponse, BuildingConfiguration, BuildingConfigurationR, BuildingInput, BuildingInputR, BuildingTemplate, BuildingTemplateR, BuildingTemplateTypeR
  - ... 还有 92 个消息

### google.internal.earth.v1.config

- **消息数量**: 47
- **用途**: 配置
- **关键消息**: AbsoluteUrlTemplate, AbsoluteUrlTemplateR, AnimatedCloudsConfigB, BillingConfig, BillingConfigR, BuiltenvConfig, BuiltenvConfigR, CelestialBodiesConfig, CelestialBodiesConfigR, CelestialBodyR
  - ... 还有 37 个消息

### google.internal.earth.v1.featureflags

- **消息数量**: 1
- **用途**: 功能管理
- **关键消息**: GetFeatureFlagsResponse

### google.internal.earth.v1.knowledge

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GetKnowledgeCardResponse

### google.internal.earth.v1.layers

- **消息数量**: 34
- **用途**: 图层管理
- **关键消息**: CreateOnDemandLayerRequest, CreateOnDemandLayerResponse, DataLayerViewR, ElevationContourInputs, ElevationContourInputsH, Feature, FeatureAttributeValue, FeatureAttributeValueR, FeatureR, GetDataLayerRequest
  - ... 还有 24 个消息

### google.internal.earth.v1.photos

- **消息数量**: 2
- **用途**: 照片服务
- **关键消息**: GetPhotosForPointResponse, GetThumbnailsForViewportResponse

### google.internal.earth.v1.quota

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: GetUserAssetQuotaRequest, GetUserAssetQuotaResponse, UserAssetQuota

### google.internal.earth.v1.search

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: HighlightableText, Result, ResultGraphics, ResultGroupDisplayOptions, ResultGroupLink, SearchResponse, SearchResultGroup, SuggestResponse, SuggestResultGroup

### google.internal.earth.v1.survey_metadata

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SurveyEvent, SurveyMetadata

### google.internal.earth.v1.terrain

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: BatchGetElevationsByPointRequest, BatchGetElevationsByPointResponse

### google.internal.earth.v1.user

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GetUserResponse

### google.internal.earth.v1.user_metadata

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: UserMetadata, UserMetadataUpdate

### google.internal.earth.v1.user_settings

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: EarthUserCountryCodes, EarthUserGeographicScales, EarthUserIndustries, UserSettings

### google.protobuf

- **消息数量**: 35
- **用途**: 功能模块
- **关键消息**: Any, AnyB, AnyBQ, AnyH, AnyR, Anytype_url, BoolValue, BytesValue, DoubleValue, Duration
  - ... 还有 25 个消息


## Maps

**命名空间数**: 19

### maps_paint

- **消息数量**: 102
- **用途**: 地图绘制
- **关键消息**: AnnotationOptionsR, AssetParametersR, AvifOptionsR, CacheOptions, ChevronParametersR, ColorTransformR, CommonStyleDataRequestR, CopyrightsOptionsR, CrisisPipeMetadata, CubemapRequestR
  - ... 还有 92 个消息

### maps_paint_client

- **消息数量**: 48
- **用途**: 地图绘制
- **关键消息**: AbsoluteLabelPosition, AbsolutePointPosition, AreaRenderOp, AreaRenderOpGroup, AreaStyle, ClientVectorTile, CompactKeyZoom, CompactMultiZoomStyle, CompactMultiZoomStyleTable, CustomTilesRequest
  - ... 还有 38 个消息

### maps_tactile

- **消息数量**: 38
- **用途**: 功能模块
- **关键消息**: AdColorR, AdStyleR, AdsEntityB, AdsEntityR, AdsParamsR, AliasIdR, AliasR, AllowedHotelAmenityR, AllowedPriceLevelR, AllowedPropertyTypeR
  - ... 还有 28 个消息

### maps_tactile.directions

- **消息数量**: 22
- **用途**: 功能模块
- **关键消息**: AnchoredTimeR, BikesharingOptionsR, CyclingOptionsR, DrivingOptionsR, ElectricVehicleChargingStationDetailsR, ElectricVehicleTripPlanningInfoR, ElevationProfileOptionsB, OffstreetParkingB, OptionsB, OptionsR
  - ... 还有 12 个消息

### maps_tactile.extensions

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DirectionsRequestInternalOnlyExtension

### maps_tactile.shared

- **消息数量**: 21
- **用途**: 功能模块
- **关键消息**: ATTManagerAuthorizationStatusR, AliasTypeR, DateR, DayOfWeekR, ExperienceCategoricalQueryH, ExperiencesParamsR, FeatureIdR, GeoWholepageTypeR, LatLngB, LatLngR
  - ... 还有 11 个消息

### maps_tactile.shared.ads

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: MapAdsRequestContextR, PlacesheetAdTypeR

### maps_tactile.shared.automotive

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ElectricVehicleOptionsR

### maps_tactile.shared.caching

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: CacheConditionR, CacheDirectiveR

### maps_tactile.shared.directions

- **消息数量**: 17
- **用途**: 功能模块
- **关键消息**: AssistedDrivingOptionsR, DirectionsClientStatsR, DynamicClosureOptionsR, FareTypeR, ImageOptionsR, OpaqueTripOptionR, OpaqueTripOptionsR, RealTimePolicyR, RetrievalClientR, RoadsideFacilityOptionsR
  - ... 还有 7 个消息

### maps_tactile.shared.hotels

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: HotelMapLayerOptionsR, ItineraryR, MapsLiveQueryConfigR

### maps_tactile.shared.layer

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: MapLayerTypeR

### maps_tactile.shared.passiveassist

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: ContentMaskR, PrefetchContextR, PrefetchTypeR, StatusR

### maps_tactile.shared.photo

- **消息数量**: 1
- **用途**: 照片服务
- **关键消息**: RenderStrategyR

### maps_tactile.shared.place

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: MapsPlaceIdentifierH, MapsPlaceIdentifierR, PlaceComparisonBadgeTypeR, PlaceComparisonDataOptionsR

### maps_tactile.shared.placelist

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: PlaceListDescriptorR, PlaceListTypeR

### maps_tactile.shared.placepreview

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: CostOptionsR, PhotoPreviewOptionsR, PlacePreviewFieldMaskR, ScalableAttributeOptionsR

### maps_tactile.shared.savedplaces

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SavedPlacesClientIdR

### maps_tactile.shared.transit

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: LongDistanceOptionsR, TransitLoggingContextR, TransitServiceQueryH


## Geo

**命名空间数**: 8

### geo.earth.app

- **消息数量**: 16
- **用途**: 功能模块
- **关键消息**: BillingUpgradeDialogSourceViewR, DataCatalogDialogSourceViewR, DeeplinkEvent, DeeplinkEventR, EarthEvent, EarthFeedEventR, ExperimentFlagsB, ExplorePromotionDialogVariantR, IndustrySelectorResponseEventR, MirthStatsEvent
  - ... 还有 6 个消息

### geo.earth.proto

- **消息数量**: 70
- **用途**: 功能模块
- **关键消息**: BaseLayerStyleConfig, BootstrapClientConfig, ClearSearchHistory, ClearSearchHistoryB, Command, CommandR, CommandSourceB, Commands, CompileTimeConfig, CreateCloudProject
  - ... 还有 60 个消息

### geo.earth.proto.earth_mate

- **消息数量**: 16
- **用途**: 功能模块
- **关键消息**: CreationContext, EarthMateAppContext, EarthMateAreaDescriptionRequest, EarthMateAreaDescriptionResponse, EarthMateAttribution, EarthMateChatContext, EarthMateChatHistory, EarthMateErrorDetail, EarthMateQueryRequest, EarthMateQueryResponse
  - ... 还有 6 个消息

### geo_photo_service

- **消息数量**: 56
- **用途**: 照片服务
- **关键消息**: AreaConnectivityRequest, AreaConnectivityResponse, AssociatedFeature, Attribution, ClientCapabilities, CursorOverlayFormat, DateTime, Description, Elevation, FreeformAnnotation
  - ... 还有 46 个消息

### geostore

- **消息数量**: 276
- **用途**: 功能模块
- **关键消息**: AccessPointPatternProtoR, AccessPointProtoB5, AccidentProneSpotProtoR, AddressComponentPatternProtoR, AddressComponentProtoB, AddressComponentProtoR, AddressLinesPatternProtoR, AddressLinesProtoR, AddressPatternProtoR, AddressProtoR
  - ... 还有 266 个消息

### geostore.attachments

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AttachmentProtoR

### geostore.fieldtype

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TypeR

### geostore.ontology

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: RawGConceptInstanceContainerProtoR, RawGConceptInstanceProtoR


## Features

**命名空间数**: 10

### earth.balloon

- **消息数量**: 40
- **用途**: 功能模块
- **关键消息**: BalloonContent, BalloonViewModelCommand, BalloonViewModelState, CarouselImage, CarouselImages, HandleEarthDeepLink, HandleEarthDeepLinkurl, HandleKmlLink, HandleKmlLinkhrefbase_url, LayerOpacity
  - ... 还有 30 个消息

### earth.document

- **消息数量**: 22
- **用途**: 文档处理
- **关键消息**: CapabilityR, DocumentKindR, DocumentMetadata, DocumentMetadataR, DocumentNamespaceR, DocumentStorageMetadata, DocumentUmsMetadata, DocumentUmsMetadataR, EarthBalloonTemplate, EarthBalloonTemplateList
  - ... 还有 12 个消息

### earth.document.proto

- **消息数量**: 3
- **用途**: 文档处理
- **关键消息**: FeatureKey, FeatureKeyR, FeatureKeykey

### earth.document.protos

- **消息数量**: 407
- **用途**: 文档处理
- **关键消息**: AccessInfo, AccessInfoR, AddColumn, AddColumnH, AddFeature, AddFeatureH, AddFeatureMedia, AddFeatureMediaH, AddressFailedGeocoding, AddressFailedGeocodingH
  - ... 还有 397 个消息

### earth.documentexport

- **消息数量**: 5
- **用途**: 文档处理
- **关键消息**: DocumentExportData, DocumentExportViewModelCommand, DocumentExportViewModelState, ExportedKml, ExportedKmlsuggested_filenamekml_content

### earth.documentimport

- **消息数量**: 25
- **用途**: 文档处理
- **关键消息**: ConfirmImportDriveDocument, ConfirmImportDriveDocumentmap_idresource_keymime_typenameencoded_url, ConfirmImportLocalDocument, ConfirmImportLocalDocumentencoded_urlname, DisplayNotification, DocumentImportViewModelCommand, DocumentImportViewModelState, DriveFileMetadata, ImportFailures, ImportKmlFromClipboardToDriveProject
  - ... 还有 15 个消息

### earth.documentpicker

- **消息数量**: 4
- **用途**: 文档处理
- **关键消息**: CreateDriveProject, DocumentPickerViewModelCommand, DocumentPickerViewModelState, FocusProject

### earth.documentsharing

- **消息数量**: 4
- **用途**: 文档处理
- **关键消息**: DocumentSharingViewModelCommand, DocumentSharingViewModelState, RenameDocument, RenameDocumentnew_title

### earth.documentview

- **消息数量**: 17
- **用途**: 文档处理
- **关键消息**: CancelImport, CommitPendingTouchSelection, ConfirmCopyDocument, ConfirmCopyDocumentcopy_title, DocumentNotification, DocumentViewViewModelCommand, DocumentViewViewModelState, OpenImportErrorGuide, PasteFeatureFromClipboard, PasteFeatureFromClipboardfeature_kml
  - ... 还有 7 个消息

### earth.layers

- **消息数量**: 32
- **用途**: 图层管理
- **关键消息**: BaseLayer, BaseLayerStyleInfo, BaseLayerStyles, BaseLayerToastEvent, BaseLayerViewModelCommand, BaseLayerViewModelState, BaseLayerVisibilities, BaseLayers, BasemapStyle, BasemapStyleInfo
  - ... 还有 22 个消息


## Quality

**命名空间数**: 3

### quality_local_ranking

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: LocalwebResponseAnnotation, LocationRankingOutput, PersonalizationPlaceEmbedding

### quality_local_ranking.justifications

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CandidateJustificationList

### quality_qrewrite

- **消息数量**: 64
- **用途**: 功能模块
- **关键消息**: AdsDebugInfo, AgentAnnotationOutput, AlternateLanguageQbstOutput, AlternativeResult, AnnotationsForGrounding, AppAnnotationOutput, AquariumServletOutput, AssistantAppIntentClassifierOutput, AssistantCortexOutput, AssistantSearchHandoverOutput
  - ... 还有 54 个消息


## Config

**命名空间数**: 3

### earth.config

- **消息数量**: 9
- **用途**: 配置
- **关键消息**: BaseLayerStyle, ConfigRequestFailed, ConfigViewModelCommand, ConfigViewModelState, LoadCachedConfigSuccess, PaintFeLayer, RasterLayer, RetryConfigRequest, StoreConfigInCache

### google.internal.earth.v1.config

- **消息数量**: 47
- **用途**: 配置
- **关键消息**: AbsoluteUrlTemplate, AbsoluteUrlTemplateR, AnimatedCloudsConfigB, BillingConfig, BillingConfigR, BuiltenvConfig, BuiltenvConfigR, CelestialBodiesConfig, CelestialBodiesConfigR, CelestialBodyR
  - ... 还有 37 个消息

### knowledge.kefi.card_config

- **消息数量**: 1
- **用途**: 配置
- **关键消息**: FilledCardGroup


## Other

**命名空间数**: 394

### a.search.next.servers.mars.flows.localplacetile.infoneeds.localplacetile

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LocalPlaceTileInfoPayload

### address_formatter

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AddressFormatterResult

### ads.shopping.qprime

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: QPrimeOutput

### ads.vasco.serving

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: QIntentDRMappingResult

### apptheme

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DarkMode, HighContrast

### assistant.incomplete_queries

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ClarificationResponse

### assistant.lamda.tool_use

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RunToolResponse

### classifier_porn

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PornClassificationAnnotation

### cloud_logging

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: REDACT

### com.google.openrtb

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ContentCategory

### commerce.intent.breakdowns_proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: VisualElementConstant

### contentads_bidder.openrtb

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ContentCategory

### datacatalog

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: HasSeenDataCatalog

### datapol

- **消息数量**: 15
- **用途**: 功能模块
- **关键消息**: AnnotationsDetailsR, EnumDetailsR, FieldDetailsR, LocationQualifierR, MessageDetailsR, QualifierR, RetentionSpecR, ST_ACCOUNT_CREDENTIAL, ST_ARES_ID, ST_PAYMENTS_PCI_SAD
  - ... 还有 5 个消息

### datapol.classification

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: OptionsR

### delve

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: HasSeenDelve, HasSeenSiteSelection

### design

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: HasSeenDesignOnboardingInfoPanel

### devtools.protoshop.external

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: AnnotationOptionsR, ParsingOptionsR, SelectorR

### earth.addbuildingtypes

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: AddBuildingInput, AddBuildingInputbuilding_template_idbuilding_template_name, AddBuildingTypesViewModelCommand, AddBuildingTypesViewModelState, LogSimpleEvent

### earth.apptheme

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: AppThemeViewModelCommand, AppThemeViewModelState

### earth.bottomsheet

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: BottomSheetViewModelCommand, BottomSheetViewModelState

### earth.boundaryselection

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: BoundarySelectionViewModelCommand, BoundarySelectionViewModelState, SelectBoundary, SelectBoundaryfeature_id

### earth.buildingtemplates

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: BuildingTemplateFarRangeInfo, BuildingTemplateFarRangeInfoR, BuildingTemplateInfo, FarRangeCategoryR

### earth.collapsedwidgets

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: CollapsedWidgetsViewModelCommand, CollapsedWidgetsViewModelState

### earth.compass

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: CompassViewModelCommand, CompassViewModelState, SetHeading, SetTilt

### earth.contouranalysis

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: ContourAnalysisViewModelCommand, ContourAnalysisViewModelState, ContourAnalysisViewModelStatemobile_see_plans_urlhelp_url, SetContourInterval

### earth.copydesigninputsdialog

- **消息数量**: 2
- **用途**: 输入事件
- **关键消息**: CopyDesignInputsDialogViewModelCommand, CopyDesignInputsDialogViewModelState

### earth.core.apptheme

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AppTheme

### earth.core.projecttools

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ProjectToolsState

### earth.core.shortcuts

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ShortcutMessage

### earth.datacatalogdialog

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: CloseDataCatalogDialog, DataCatalogDialogViewModelCommand, DataCatalogDialogViewModelState, DataCatalogDialogViewModelStatemobile_see_plans_url, OnLayerButtonPressed, OnLayerButtonPressedlayer_id, OpenLayerMetadata, OpenLayerMetadatalayer_id

### earth.delve

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: DelveConfig, DelveViewModelCommand, DelveViewModelState, LaunchDelveUrlEvent, ParcelAnalysis

### earth.design

- **消息数量**: 17
- **用途**: 功能模块
- **关键消息**: DesignMapResult, DesignResult, DesignResultR, DownloadDesignFileRequest, DownloadDesignFileResponse, DownloadDesignFileResponseH, Filter, FilterR, NewBuildToplineMetrics, NewBuildToplineMetricsH
  - ... 还有 7 个消息

### earth.designbuiltentity

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DesignBuiltEntityViewModelCommand, DesignBuiltEntityViewModelState

### earth.designdetails

- **消息数量**: 50
- **用途**: 功能模块
- **关键消息**: AreaMetrics, AreaMetricsR, DesignDetailsViewModelCommand, DesignDetailsViewModelState, DesignStatsMetrics, DesignStatsMetricsR, DownloadDesignFile, EmissionsSummaryMetrics, EmissionsSummaryMetricsR, ExportDesignFile
  - ... 还有 40 个消息

### earth.designeditor

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DesignEditorViewModelCommand, DesignEditorViewModelState

### earth.designexport

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PendingExport

### earth.designinput

- **消息数量**: 3
- **用途**: 输入事件
- **关键消息**: DesignGenerationResult, GenerateDesignsRequestStateR, MaxSiteAreaStateR

### earth.designinputmodechooser

- **消息数量**: 2
- **用途**: 输入事件
- **关键消息**: DesignInputModeChooserViewModelCommand, DesignInputModeChooserViewModelState

### earth.designinputvalidation

- **消息数量**: 10
- **用途**: 输入事件
- **关键消息**: DesignValidation, FieldValidRange, InputCategoryValidationErrors, ProgramErrorContext, UseTypeErrorContext, ValidInputRanges, ValidRange, ValidationError, ZoningErrorContext, ZoningInputRanges

### earth.designviewer

- **消息数量**: 18
- **用途**: 功能模块
- **关键消息**: DesignViewerViewModelCommand, DesignViewerViewModelState, DownloadDesignFile, ExportDesignFile, ExportDesignFiledesign_iddesign_name, OpenDesignDetails, OpenDesignDetailsdesign_id, OpenDesignEditor, OpenDesignEditordesign_id, RequestDesigns
  - ... 还有 8 个消息

### earth.document.protos

- **消息数量**: 407
- **用途**: 文档处理
- **关键消息**: AccessInfo, AccessInfoR, AddColumn, AddColumnH, AddFeature, AddFeatureH, AddFeatureMedia, AddFeatureMediaH, AddressFailedGeocoding, AddressFailedGeocodingH
  - ... 还有 397 个消息

### earth.documentsharing

- **消息数量**: 4
- **用途**: 文档处理
- **关键消息**: DocumentSharingViewModelCommand, DocumentSharingViewModelState, RenameDocument, RenameDocumentnew_title

### earth.experiments

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: AllowFlagOverrides, ExperimentFlags, ExperimentFlagsR, ExperimentIds, ExperimentsViewModelCommand, ExperimentsViewModelState, OverrideFlagValues, SetPhenotypeFlags, SetPhenotypeServerToken, SetPhenotypeServerTokentoken

### earth.filters

- **消息数量**: 12
- **用途**: 功能模块
- **关键消息**: AttributeFilterData, AttributeFilterDatakeylocalized_name, CategoricalFilterData, DataLayerFilters, DataLayerFiltersfilters, DoubleRange, FilterOption, FilterOptionvalue_idlocalized_name, IntRange, Range
  - ... 还有 2 个消息

### earth.hats

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: HatsViewModelCommand, HatsViewModelState, PresentSurveyFailed, PresentSurveyFailedtrigger_id, PresentSurveySucceeded, PresentSurveySucceededtrigger_id, SurveyTriggerEvent

### earth.homescreen

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: AddDocumentWithKmlContent, AddDocumentWithKmlContentname, AddEmptyDriveDesignDocument, AddEmptyDriveDocument, AddEmptyLocalDocument, DismissHomescreen, HomescreenViewModelCommand, HomescreenViewModelState, RequestOpenDriveDocumentDialog, RequestOpenLocalFileDialog
  - ... 还有 1 个消息

### earth.industryselector

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: DismissBanner, IndustrySelectorSurveyInputs, IndustrySelectorSurveyQuestion, IndustrySelectorSurveyQuestions, IndustrySelectorViewModelCommand, IndustrySelectorViewModelState, ShowBanner, ShowSurveyDialog, UpdateSurveyInputs

### earth.inspector

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: InspectorViewModelCommand, InspectorViewModelState

### earth.killswitch

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: KillSwitchViewModelCommand, KillSwitchViewModelState

### earth.layerdetails

- **消息数量**: 37
- **用途**: 图层管理
- **关键消息**: AddFilter, AddFilterattribute_key, AttributeDrivenColor, BringLayerToFront, DeleteFilter, DeleteFilterattribute_key, DeleteLayer, EditLayer, FilterState, LabelStyle
  - ... 还有 27 个消息

### earth.layers

- **消息数量**: 32
- **用途**: 图层管理
- **关键消息**: BaseLayer, BaseLayerStyleInfo, BaseLayerStyles, BaseLayerToastEvent, BaseLayerViewModelCommand, BaseLayerViewModelState, BaseLayerVisibilities, BaseLayers, BasemapStyle, BasemapStyleInfo
  - ... 还有 22 个消息

### earth.localfilesystem

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: FileMetadata

### earth.mapspaceediting

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: MapSpaceEditingViewModelCommand, MapSpaceEditingViewModelState, Model, UpdateFeatureProperties

### earth.measuretool

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: MeasureToolViewModelCommand, MeasureToolViewModelState, SetUseTouchBasedDrawing

### earth.navigationcontrols

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: NavigationControlsViewModelCommand, NavigationControlsViewModelState

### earth.networkmonitor

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: NetworkMonitorViewModelCommand, NetworkMonitorViewModelState, ToastContents

### earth.newbuilddesigninput

- **消息数量**: 10
- **用途**: 输入事件
- **关键消息**: InitiateGenerateDesigns, LicenseConfig, LogSimpleEvent, NewBuildDesignInputViewModelCommand, NewBuildDesignInputViewModelState, NewBuildUserInputs, ResetParcelZoning, ResetParcelZoningparcel_id, TopLevelErrorMessage, UpdateUserInputs

### earth.pinnedprojects

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: PinnedProjectsViewModelCommand, PinnedProjectsViewModelState, StageDocumentPin, StageDocumentUnpin

### earth.projectslist

- **消息数量**: 47
- **用途**: 功能模块
- **关键消息**: AddDriveDocumentWithUmsMapId, AddDriveDocumentWithUmsMapIdmap_idresource_keydocument_mime_typename, AddEmptyDriveDesignDocument, AddEmptyDriveDocument, AddEmptyLocalDocument, AddLocalDocumentWithKmlContent, AddLocalDocumentWithKmlContentname, AddLocalDocumentWithUrl, AddLocalDocumentWithUrlurlname, ClearLastModifiedTimeFilter
  - ... 还有 37 个消息

### earth.requestaccess

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: RequestAccessViewModelCommand, RequestAccessViewModelState, RequestAccessViewModelStateproject_titlelearn_more_urlemail_message, UpdateEmailMessage, UpdateEmailMessagemessage

### earth.screenshotsharing

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: ScreenshotSharingViewModelCommand, ScreenshotSharingViewModelState

### earth.search

- **消息数量**: 13
- **用途**: 功能模块
- **关键消息**: FlyToResult, PerformGroupCommand, PerformResultCommand, RequestSearchResultGroupPage, RequestSearchResultGroupPagepage_token, SearchViewModelCommand, SearchViewModelState, SetEarthViewVisibleHeightPercentageDuringSearch, SetSearchState, SetSearchStatequery
  - ... 还有 3 个消息

### earth.settings

- **消息数量**: 22
- **用途**: 功能模块
- **关键消息**: BoolSetting, ClearValue, ClearValuekey_path, EnumSetting, GetValue, GetValuekey_pathdefault_value, InfoSetting, Init, MultiEnumSetting, RemoveSettingEvent
  - ... 还有 12 个消息

### earth.sharingpolicy

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SharingPolicyViewModelCommand, SharingPolicyViewModelState

### earth.shortcuts

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: ShortcutInvoked, ShortcutsViewModelCommand, ShortcutsViewModelState

### earth.siteselection

- **消息数量**: 12
- **用途**: 功能模块
- **关键消息**: AreaDescription, EditAreaPolygon, LayerConfig, LicenseConfig, Parcel, ParcelInfo, PendingAreaConfig, PendingAreaInfo, RemoveParcel, SiteSelectionResult
  - ... 还有 2 个消息

### earth.solardesigninput

- **消息数量**: 12
- **用途**: 输入事件
- **关键消息**: InitiateGenerateDesigns, LicenseConfig, LicenseConfigR, ParcelInput, ParcelInputR, SolarDesignInputViewModelCommand, SolarDesignInputViewModelState, SolarUserInputs, SolarUserInputsR, StartWithNewDraftRequestStateH
  - ... 还有 2 个消息

### earth.splashscreen

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SplashScreenViewModelCommand, SplashScreenViewModelState

### earth.state

- **消息数量**: 133
- **用途**: 状态管理
- **关键消息**: DataState, DataStateR, LatLonBox, LatLonBoxR, LayerFeatureAttribute, LayerFeatureAttributeR, LayerFeatureDetailsData, LayerFeatureDetailsDataH, NonRestorableAccountData, NonRestorableAccountDataR
  - ... 还有 123 个消息

### earth.state.derivedstate

- **消息数量**: 104
- **用途**: 状态管理
- **关键消息**: AddBuildingTypesDerivedState, AppRootDerivedState, AppThemeDerivedState, AreaFilterDerivedState, AreaFilterDerivedStatelayer_namelayer_logging_id, BackNavigationDerivedState, BalloonDerivedState, BasemapStyleState, BasemapStyleStateR, BottomSheetDerivedState
  - ... 还有 94 个消息

### earth.streetview

- **消息数量**: 20
- **用途**: 功能模块
- **关键消息**: CapturedStreetViewEvent, CollapseTimeline, EnterStreetView, ExpandTimeline, KeyboardEnterStreetView, LoadPanoThumbsEvent, NavigateToNeighborPano, PanoId, PanoTimeline, SeekNextTimelineDate
  - ... 还有 10 个消息

### earth.styleeditor

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: Icon, RecentIcons, StockIcon, StockIconCategory, StockIcons

### earth.system

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: SetMemoryUsageTargetMb, SetRenderSceneEnabled, SystemViewModelCommand, SystemViewModelState

### earth.time

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DateTime

### earth.timelapse

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: SetTimelapseFramerateMultiplier, TimelapseViewModelCommand, TimelapseViewModelState

### earth.timemachine

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: Date, DateState, DateStateMessageUpdate, SetDate, SetDateiso_date, TimeMachineViewModelCommand, TimeMachineViewModelState, UpdateDateState, Year, YearMessageUpdate

### earth.toast

- **消息数量**: 12
- **用途**: 功能模块
- **关键消息**: ToastInvalidKml, ToastProjectDuplicated, ToastProjectDuplicatedproject_title, ToastProjectMovedToTrash, ToastProjectRenamed, ToastProjectRenamedold_titlenew_title, ToastRequestAccessFailed, ToastRequestAccessSent, ToastSlideShowGenerated, ToastTooManyFeaturesForBulkEdit
  - ... 还有 2 个消息

### earth.unitconversion

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: AutoUnits, AvailableUnits, DefaultUnits, SetAreaUnit, SetDistanceUnit, SetSlopeUnit, Unit, UnitCategories, UnitConversionViewModelCommand, UnitConversionViewModelState
  - ... 还有 1 个消息

### earth.urlsharing

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: ConfirmDialog, SetAdditionalUrlParameters, SetAdditionalUrlParametersparameters, ShareInfo, UrlSharingViewModelCommand, UrlSharingViewModelState

### earth.usererrors

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: Action, TakeAction, UserErrorItem, UserErrorsViewModelCommand, UserErrorsViewModelState

### earth.viewstatus

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: AltitudeWithUnits, ImageryAcquisitionDateRange, LoadProgress, PointerCoordinates, ScaleBarData, SetMaxScaleBarUiLength, ViewStatus, ViewStatusViewModelCommand, ViewStatusViewModelState

### earth.zoombuttons

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: ZoomButtonsViewModelCommand, ZoomButtonsViewModelState

### earth_knowledge

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RenderableEntity

### earth_photos

- **消息数量**: 1
- **用途**: 照片服务
- **关键消息**: ThumbnailImage

### experiments.heterodyne

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ExperimentIdsR

### fatcat

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CompactDocClassification

### forum_ranking

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ForumPosts

### freebase

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: CitationB, IdR, LatLongB, MeasurementB, NestedStructR, PropertyValueR, TopicR, Value, ValueR

### freshness

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: FreshnessTwiddlerDocAnnotations, QuerySignals

### geo.casemap.search

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: SearchPaintParams, SearchPipeMetadata, VerticalizedLabelStyleR

### geo.experience

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GeoExperienceCategoryR

### geo.mobrank.lore

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: BasemapIntentBoostingParams, BasemapLocalVsTouristParams, BasemapP13nParams, BasemapRecommendationsParams, StaticLabelsParams, UserContextSignalParams

### geo.mobrank.lore.evcs

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: EvcsParams

### geo_contentflows_serving

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ListContentByRegionResponse

### geo_enterprise_common

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: GranularityR, ProtoMergerFieldOptionsR, ProtoMergerOptionsR

### geo_globetrotter_proto_rocktree

- **消息数量**: 13
- **用途**: 功能模块
- **关键消息**: AcquisitionDate, AcquisitionDateRange, BulkMetadata, Copyright, Copyrights, DatedCopyright, DatedNode, Mesh, NodeData, NodeKey
  - ... 还有 3 个消息

### geo_photo

- **消息数量**: 2
- **用途**: 照片服务
- **关键消息**: ImageryCoverageMetadata, RankingOptions

### geo_photo_service

- **消息数量**: 56
- **用途**: 照片服务
- **关键消息**: AreaConnectivityRequest, AreaConnectivityResponse, AssociatedFeature, Attribution, ClientCapabilities, CursorOverlayFormat, DateTime, Description, Elevation, FreeformAnnotation
  - ... 还有 46 个消息

### geo_serving_proto.address

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: AddressComponentsR, AddressOptionsB, AddressR, FormattedAddressTypeR, OpenLocationCodeR, PlusCodePlacesheetPriorityR

### geo_serving_proto.ads

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AdRefR

### geo_serving_proto.color

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ColorSetR

### geo_serving_proto.crisis

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CrisisCategoryR

### geo_serving_proto.directions

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: EngineTypeR, FuelConsumptionRoutingOptionsR, TrailerPhysicalAttributesR, VehiclePhysicalAttributesR, VehicleTypeOptionsR

### geo_serving_proto.directions.request

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: BikesharingDecorationsVersionR, CyclingDecorationsVersionR, DecorationOptionsR, EntranceOptionsR, ParkingOptionsR, TraileringDecorationsVersionR, TraileringRoutingOptionsR, WalkingDecorationsVersionR

### geo_serving_proto.electricvehicle

- **消息数量**: 23
- **用途**: 功能模块
- **关键消息**: BatteryLossesR, ChargingArchitectureR, ChargingCurvesR, ChargingTimeR, DrainAtTemperatureR, DrainAtTimeR, DrivetrainLossesR, ElectricVehicleChargingSpeedR, ElectricVehicleConnectorR, ElectricVehicleOptionsR
  - ... 还有 13 个消息

### geo_serving_proto.eligibility

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: UgcEligibility

### geo_serving_proto.foodordering

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: Providers

### geo_serving_proto.foodwaittimes

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: FoodWaitTimeEstimate, FoodWaitTimeSearchParams

### geo_serving_proto.geometry

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: LatLngB, LatLngR, LatLngRectangleH

### geo_serving_proto.hotels

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: OccupancyR, OccupancyTypeR, SupportedOccupancyR

### geo_serving_proto.intents

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ActionIntentR

### geo_serving_proto.link

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: LinkH, LinkR

### geo_serving_proto.localactions

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ViewMenuAction

### geo_serving_proto.localcategorical

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: IntentTypeR

### geo_serving_proto.omnimaps

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: MapViewportInfoR, OmniMapsDataR, PublishedMapInfoR, SelectedItemInfoR

### geo_serving_proto.photos

- **消息数量**: 2
- **用途**: 照片服务
- **关键消息**: ImageFormatR, ImageFrontendTypeR

### geo_serving_proto.place

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PlaceIdentifierB

### geo_serving_proto.placeactions

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: LensAction, PopulusAvailabilityExtractorParams, ReservationEndToEndAction, TableAvailability

### geo_serving_proto.review

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ReviewSnippet

### geo_serving_proto.socialproof

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SocialProofSearchParams, SocialProofSignals

### geo_serving_proto.text

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: AnnotatedTextR, FontSizeR, FontWeightR, SpanR, TextStyleR

### geo_serving_proto.ugc.summarization

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TopAspectR

### geo_sidewalklabs_delve.earth

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: CreateStudyRequest, Geometry, VertexList2D

### geometry2d

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: R2PointProtoB, R2PointProtoR, R2PolylineProtoR, R2TransformerProtoR

### geostore

- **消息数量**: 276
- **用途**: 功能模块
- **关键消息**: AccessPointPatternProtoR, AccessPointProtoB5, AccidentProneSpotProtoR, AddressComponentPatternProtoR, AddressComponentProtoB, AddressComponentProtoR, AddressLinesPatternProtoR, AddressLinesProtoR, AddressPatternProtoR, AddressProtoR
  - ... 还有 266 个消息

### geostore.attachments

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AttachmentProtoR

### geostore.fieldtype

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TypeR

### geostore.ontology

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: RawGConceptInstanceContainerProtoR, RawGConceptInstanceProtoR

### google.api

- **消息数量**: 34
- **用途**: 功能模块
- **关键消息**: ApiInclusionB, AuthorizationRuleB, AuthorizationRuleR, BatchingConfigProtoB, BatchingDescriptorProtoR, BatchingSettingsProtoR, ClientLibraryDestinationB, ClientLibraryOrganizationB, ClientLibrarySettingsB, CommonLanguageSettingsB
  - ... 还有 24 个消息

### google.internal.earth.v1

- **消息数量**: 57
- **用途**: 功能模块
- **关键消息**: AppliedStyleRules, AppliedStyleRulesR, AttributeValue, AttributeValueR, CategoricalFilterSet, CategoricalFilterSetH, CategoricalStyleMethod, CategoricalStyleMethodR, ClientMetadata, ClientMetadataB
  - ... 还有 47 个消息

### google.internal.earth.v1.billing

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: License, ListLicensesResponse

### google.internal.earth.v1.builtenv

- **消息数量**: 102
- **用途**: 功能模块
- **关键消息**: AddFloorsEditH, AdjustBlockProgramEditH, BatchGetUserQuotasResponse, BuildingConfiguration, BuildingConfigurationR, BuildingInput, BuildingInputR, BuildingTemplate, BuildingTemplateR, BuildingTemplateTypeR
  - ... 还有 92 个消息

### google.internal.earth.v1.config

- **消息数量**: 47
- **用途**: 配置
- **关键消息**: AbsoluteUrlTemplate, AbsoluteUrlTemplateR, AnimatedCloudsConfigB, BillingConfig, BillingConfigR, BuiltenvConfig, BuiltenvConfigR, CelestialBodiesConfig, CelestialBodiesConfigR, CelestialBodyR
  - ... 还有 37 个消息

### google.internal.earth.v1.featureflags

- **消息数量**: 1
- **用途**: 功能管理
- **关键消息**: GetFeatureFlagsResponse

### google.internal.earth.v1.knowledge

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GetKnowledgeCardResponse

### google.internal.earth.v1.layers

- **消息数量**: 34
- **用途**: 图层管理
- **关键消息**: CreateOnDemandLayerRequest, CreateOnDemandLayerResponse, DataLayerViewR, ElevationContourInputs, ElevationContourInputsH, Feature, FeatureAttributeValue, FeatureAttributeValueR, FeatureR, GetDataLayerRequest
  - ... 还有 24 个消息

### google.internal.earth.v1.photos

- **消息数量**: 2
- **用途**: 照片服务
- **关键消息**: GetPhotosForPointResponse, GetThumbnailsForViewportResponse

### google.internal.earth.v1.quota

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: GetUserAssetQuotaRequest, GetUserAssetQuotaResponse, UserAssetQuota

### google.internal.earth.v1.search

- **消息数量**: 9
- **用途**: 功能模块
- **关键消息**: HighlightableText, Result, ResultGraphics, ResultGroupDisplayOptions, ResultGroupLink, SearchResponse, SearchResultGroup, SuggestResponse, SuggestResultGroup

### google.internal.earth.v1.survey_metadata

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: SurveyEvent, SurveyMetadata

### google.internal.earth.v1.terrain

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: BatchGetElevationsByPointRequest, BatchGetElevationsByPointResponse

### google.internal.earth.v1.user

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GetUserResponse

### google.internal.earth.v1.user_metadata

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: UserMetadata, UserMetadataUpdate

### google.internal.earth.v1.user_settings

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: EarthUserCountryCodes, EarthUserGeographicScales, EarthUserIndustries, UserSettings

### google.longrunning

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: CancelOperationRequest, DeleteOperationRequest, GetOperationRequest, ListOperationsRequest, OperationInfoR, OperationR, WaitOperationRequest

### google.protobuf

- **消息数量**: 35
- **用途**: 功能模块
- **关键消息**: Any, AnyB, AnyBQ, AnyH, AnyR, Anytype_url, BoolValue, BytesValue, DoubleValue, Duration
  - ... 还有 25 个消息

### google.rpc

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: Status, StatusH, StatusR, Statusmessage

### google.type

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: Color, Date, DateR, DateTimeR, TimeZoneH

### googlesql

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TableTypeR

### gws

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: GeolocationContextB, LanguageContextB, UserIpContextB, WebParametersRequestContextB

### gws.mothership

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: FieldPathCollectionR, HeaderAndFieldPathR, HttpEndpointLoadBalancingTypeR, MothershipRequestOptionsR, MothershipResponseOptionsR, MothershipRpcOptionsR, OnePlatformHeadersToCopyR

### hkb

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: ClaimEmbedData, EntityKnowledge, HybridKnowledge, KnowledgeResult

### homescreen

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: ActiveProjectsList, DriveSortDirection, DriveSortKey, HasSeenImportFileToProjectMenuItem, KmlSortAttribute, KmlSortDirection

### homescreen.cloud

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: LastModifiedTimeFilter, PeopleFilter, PeopleTokenFilter

### homescreen.kml

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LastModifiedTimeFilter

### hotels.experiences

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LodgingAreaSummary

### i18n.localization

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: LocalizedTextProto, LocalizedTextProtoR, LocalizedTextSetProtoR

### i18n.phonenumbers

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PhoneNumberB

### image.sfp

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ImageResultData

### image_content

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: FlowProtoProd

### image_mustang

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: FaviconBase64Data

### image_quality.salient_terms

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ImageSalientTermSetContainer

### image_quality_sensitive

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SensitiveAnnotation

### immersive_augmentations_layer

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: AugmentationsParameters

### jspb

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: JsTypeR

### jsproto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: Type

### ke.governance

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TypedRegionsR

### keyhole

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SatelliteExperimentParameters

### kg_schema.fmt

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: FieldFormatOptionsR, MessageFormatOptionsR, SortByOptionsR

### knowledge

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: EvaluatorSpecificInstrumentation, QueryInterpretationSet, ScoringSignals

### knowledge.extraction.vortal.retrieval

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: Entity, TabularResult

### knowledge.kefi.card_config

- **消息数量**: 1
- **用途**: 配置
- **关键消息**: FilledCardGroup

### knowledge.model

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: Video

### knowledge.proto

- **消息数量**: 22
- **用途**: 功能模块
- **关键消息**: BrowserToolResult, CodeExecutionResult, CurrencyToolResult, DescribeExtensionResult, FinanceSqlToolResult, FinanceToolAdditionalTimeSeriesResult, FinanceToolResult, MusicArtistToolResult, NewShowtimesResult, Pagination
  - ... 还有 12 个消息

### knowledge.verticals.books.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: BookResultData

### knowledge.verticals.media.api

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: MediaResponse

### knowledge.verticals.media.guided_entity

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GuidedEntityIntent

### knowledge.verticals.media.video_games.proto.categorical

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: WebAnswerJustifications

### knowledge.verticals.tvandmovies.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: MagiW2wItem

### knowledge_answers.intent_query

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: FunctionCall

### knowledge_context

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DiscourseContext

### knowledge_graph

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: DateTimeProtoH, NestedStructH, QualifierR, QualifierSetR, SourceContentReferenceR, TripleObjR, TripleR, TripleSetR

### knowledge_relatedness.broad_queries

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: BroadQueryChips

### knowledge_trust.risk_engine.serving_protections

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TrustRiskEngineSignals

### lens

- **消息数量**: 24
- **用途**: 功能模块
- **关键消息**: ImageDermConditions, ImageEntropy, ImageExactMatchReferrers, ImageFilteredOcrTerms, ImageGlof, ImageIcaLabels, ImageInterpretations, ImageLensFace, ImageLensOcrFeatures, ImageNearDupFeatures
  - ... 还有 14 个消息

### lens.backend

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: QueryInfo

### lens.infra.analytics

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CopyOptionsR

### live_result.weather

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: WeatherData

### localsearch.localactions.offering

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PlaceOfferingsRequestParams

### location.unified

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LocationContext

### location_intervention_decider

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LocationInterventionDeciderData

### logs

- **消息数量**: 14
- **用途**: 功能模块
- **关键消息**: CardinalDirectionR, ClickTrackingCGIH, ClickTrackingCGIR, ClientInteractionMetadataR, DataElementR, RankableUnitMetadata, TaggingFieldOptionsR, UIStateR, UserActionR, VeOffsetIdentifierR
  - ... 还有 4 个消息

### logs.feature

- **消息数量**: 3
- **用途**: 功能管理
- **关键消息**: FeatureOffsetIdentifierH, IndexData, TreeRefR

### logs.proto.quality

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: OrbitDocLog

### logs.proto.rtc.meet

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: MeetAnalyticsInteractionMetadataB1

### logs.proto.searchbox

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: ActionInfoR, ActionTypeR, ActionsOnGoogleAnnotationR, SearchboxStatsGroupR

### logs_gmm

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: NamedServerVersionR, ServerVersionMetadataR

### logs_images

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ImagesResultSummaryProto

### logs_maps_shared

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TravelIntentDataB

### logs_proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: MessageDetailsR

### logs_proto_searchbox

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SearchboxStatsR

### maps.crisis.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CrisisPaintParameters

### maps.indoor

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: IndoorBuildingProto, IndoorLevelProto, IndoorLevelReference, IndoorRelationProto

### maps.paint.logging.testextensions

- **消息数量**: 2
- **用途**: 地图绘制
- **关键消息**: TestOnlyLayerDescription, TestOnlyLayerDescriptionVetted

### maps_api

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: MapsApiLayerR, MapsApiMetadataProto

### maps_layers.areabusyness

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: AreaBusynessParams

### maps_layers.buildings

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: BuildingsParameters

### maps_layers.buildingselection

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: BuildingSelectionPipeMetadata

### maps_layers.laneawarepolylineevals

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: LapDebugVisualizationParamsJ

### maps_layers.photopins

- **消息数量**: 1
- **用途**: 照片服务
- **关键消息**: PhotopinsParams

### maps_layers.shared_render_ops_debug

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: SharedRenderOpsPaintParams

### maps_layers.static_labels

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: StaticLabelsRequestParams

### maps_paint

- **消息数量**: 102
- **用途**: 地图绘制
- **关键消息**: AnnotationOptionsR, AssetParametersR, AvifOptionsR, CacheOptions, ChevronParametersR, ColorTransformR, CommonStyleDataRequestR, CopyrightsOptionsR, CrisisPipeMetadata, CubemapRequestR
  - ... 还有 92 个消息

### maps_paint_client

- **消息数量**: 48
- **用途**: 地图绘制
- **关键消息**: AbsoluteLabelPosition, AbsolutePointPosition, AreaRenderOp, AreaRenderOpGroup, AreaStyle, ClientVectorTile, CompactKeyZoom, CompactMultiZoomStyle, CompactMultiZoomStyleTable, CustomTilesRequest
  - ... 还有 38 个消息

### maps_render.querytile

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: BusynessParams

### maps_roadtraffic

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: IncidentMetadata, RoadIndexPresenceR, TrafficDataServerLogDataR, TrafficLayerPaintParameters, TrafficModelTypeR, TravelModeR, TrimmedSpeedReadingR

### maps_shared.geom

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: CameraB, CameraR, LocationB, LookAheadR, MapsCameraViewportDiffFromExperimentB, RotationR, SizeR

### maps_spotlight

- **消息数量**: 21
- **用途**: 功能模块
- **关键消息**: AdsLayerParamsB, AlternateIdR, ClientOptionsR, ClientSpecifiedCrisisB, ConversationalSearchParamsR, CrisisFilterR, CrisisOptionsR, ExplicitFeatureR, ExploreSearchParamsR, HotelOptionsR
  - ... 还有 11 个消息

### maps_tactile

- **消息数量**: 38
- **用途**: 功能模块
- **关键消息**: AdColorR, AdStyleR, AdsEntityB, AdsEntityR, AdsParamsR, AliasIdR, AliasR, AllowedHotelAmenityR, AllowedPriceLevelR, AllowedPropertyTypeR
  - ... 还有 28 个消息

### maps_tactile.directions

- **消息数量**: 22
- **用途**: 功能模块
- **关键消息**: AnchoredTimeR, BikesharingOptionsR, CyclingOptionsR, DrivingOptionsR, ElectricVehicleChargingStationDetailsR, ElectricVehicleTripPlanningInfoR, ElevationProfileOptionsB, OffstreetParkingB, OptionsB, OptionsR
  - ... 还有 12 个消息

### maps_tactile.extensions

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DirectionsRequestInternalOnlyExtension

### maps_tactile.shared

- **消息数量**: 21
- **用途**: 功能模块
- **关键消息**: ATTManagerAuthorizationStatusR, AliasTypeR, DateR, DayOfWeekR, ExperienceCategoricalQueryH, ExperiencesParamsR, FeatureIdR, GeoWholepageTypeR, LatLngB, LatLngR
  - ... 还有 11 个消息

### maps_tactile.shared.ads

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: MapAdsRequestContextR, PlacesheetAdTypeR

### maps_tactile.shared.automotive

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ElectricVehicleOptionsR

### maps_tactile.shared.caching

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: CacheConditionR, CacheDirectiveR

### maps_tactile.shared.directions

- **消息数量**: 17
- **用途**: 功能模块
- **关键消息**: AssistedDrivingOptionsR, DirectionsClientStatsR, DynamicClosureOptionsR, FareTypeR, ImageOptionsR, OpaqueTripOptionR, OpaqueTripOptionsR, RealTimePolicyR, RetrievalClientR, RoadsideFacilityOptionsR
  - ... 还有 7 个消息

### maps_tactile.shared.hotels

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: HotelMapLayerOptionsR, ItineraryR, MapsLiveQueryConfigR

### maps_tactile.shared.layer

- **消息数量**: 1
- **用途**: 图层管理
- **关键消息**: MapLayerTypeR

### maps_tactile.shared.passiveassist

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: ContentMaskR, PrefetchContextR, PrefetchTypeR, StatusR

### maps_tactile.shared.photo

- **消息数量**: 1
- **用途**: 照片服务
- **关键消息**: RenderStrategyR

### maps_tactile.shared.place

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: MapsPlaceIdentifierH, MapsPlaceIdentifierR, PlaceComparisonBadgeTypeR, PlaceComparisonDataOptionsR

### maps_tactile.shared.placelist

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: PlaceListDescriptorR, PlaceListTypeR

### maps_tactile.shared.placepreview

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: CostOptionsR, PhotoPreviewOptionsR, PlacePreviewFieldMaskR, ScalableAttributeOptionsR

### maps_tactile.shared.savedplaces

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SavedPlacesClientIdR

### maps_tactile.shared.transit

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: LongDistanceOptionsR, TransitLoggingContextR, TransitServiceQueryH

### maps_util

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: TileBitmapB, TileCoordinateProto, TileCoordinateProtoB, TileCoordinateProtoR

### mirth.api

- **消息数量**: 30
- **用途**: 功能模块
- **关键消息**: CategoricalFilter, CategoricalFilterSet, CategoricalStyleRule, CategoricalStyleRuleSet, Color, ColorPalette, ColorRamp, CustomIntervalInput, CustomIntervals, DataLayerAttributeFilters
  - ... 还有 20 个消息

### mirth.diskcache

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: CacheMetadata, DiffTileMetadata

### mirth.map

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: MapsKey, TileKey

### motorcycles.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: KBYBSummary

### mustang_repos_www

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SocialMediaAttachment

### network

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: KnownThirdPartyDomains

### news.corpus

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: NewsCorpusStatusAnnotation, PageTypeAnnotation

### nlp_saft

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LangIdResult

### nlp_semantic_parsing

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AnalyzerResponse

### oogle

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LongRunning

### pathfinder

- **消息数量**: 15
- **用途**: 功能模块
- **关键消息**: CostDataSourceR, CrpAnalyticsDataR, CrpCounterfactualDataR, CrpLogDataR, CrpStatusR, EfDataR, EtaAdjustmentB, ExperimentalParametersB, ExperimentalParametersR, FindPathLatencyR
  - ... 还有 5 个消息

### pattributes

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: CollectionBasisAnd2R, CollectionBasisAndH, CollectionBasisH, CollectionBasisOr2R, CollectionBasisOrR, CollectionBasisR, ProtoFieldAttributesR, ProtoFieldUploadJustificationR

### pb

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: CppFeatures, CppFeaturesR, GoFeatures, InternalFieldOptionsb, JavaFeatures, JavaFeaturesR, JavaMutableFeatures, PythonFeatures

### privacy.ads.user_data_enforcement

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DataUsageBb

### proto.commandline.unittest.crumple.zone

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: Bar

### proto2

- **消息数量**: 46
- **用途**: 功能模块
- **关键消息**: DescriptorProto, DescriptorProtoR, Edition, EditionB, EditionR, Empty, EnumDescriptorProto, EnumDescriptorProtoR, EnumOptions, EnumOptionsR
  - ... 还有 36 个消息

### proto2.bridge

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: MessageSet, MessageSetB, MessageSetR

### proto2.contrib.http

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ProtoFormatR

### proto2.internal

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: AliasedDescriptorProto, AliasedEnumDescriptorProto, AliasedFieldDescriptorProto, AliasedFileDescriptorProto, AliasedServiceDescriptorProto

### proto_best_practices

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: FindingOptoutsR

### proto_compare

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: ComparisonOptionsR, ExcludeReasonR, FieldDispositionR, FileUseCaseR, RedactionOptionsR, TpcTypeR

### protomesh

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: SchemaAnnotationR, StagingProto, TextR

### quality.clir

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ClirSignals

### quality.horizon.jobs.proto

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: JobPostingsQueryInputs, JobPostingsResultData, JobPostingsResultMetadata, JobResultData

### quality.horizon.recipes.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RecipeResultGroup

### quality.libra.proto

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: LibraAnnotation, LibraQueryAnnotations, RelevanceOracleTwiddlerResultSignals

### quality.navboost.serving

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GlueQueryFeatures

### quality.qrewrite.servlets.proto

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: LanguageAgnosticOutput, Translations

### quality.tetris.ranking

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TetrisAnnotation

### quality_brain

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RankChainPredictions

### quality_crow_sandworm

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SandwormLocalness

### quality_datavoids

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DataVoidsWebAnnotation, DataVoidsWebResponse

### quality_dni

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ResultPreviewPolicy

### quality_dni.quality_mox

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ModernFormatContent

### quality_explore.queryable_feed

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: DiscoverQuerySignals, DiscoverResultSignals

### quality_featuresafety

- **消息数量**: 2
- **用途**: 功能管理
- **关键消息**: FeatureSafetyResult, SafetySignals

### quality_fringe

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: FringeAnnotation, FringeQueryPriorPerDocData

### quality_geo_localness

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: QueryInfoResponse

### quality_lisztomania

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: AggregatedAnswer, ListSeekingClassification

### quality_local_ranking.justifications

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CandidateJustificationList

### quality_nearby

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: NearbyTwiddlerDocAnnotations

### quality_nsr

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: NsrSitechunkSignals

### quality_oracle

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: OracleResponse

### quality_orbit

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: Classification, OrbitFeatures

### quality_orbit.asteroid_belt

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DocumentIntentScores

### quality_popfeeds

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: NewsUnderstanding, PopfeedsScores, SharedNewsResultSignals, StreamSignals

### quality_ranklab

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: FeatureLog, ResultAnnotation

### quality_realtime

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RealtimeResultInfo

### quality_realtime.boost

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RealtimeBoostResult

### quality_salient_terms

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SalientTermSetContainer

### quality_scoring.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ScoringBundle

### quality_sitemap

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: MegaSitelinksClusterData

### quality_sos

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SosClassificationInfo

### quality_stream

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: StreamSimplifiedSnippet, TopStoriesPreview, TopicOfDiscussionPreview, UGCPopfeedsPreview

### quality_tangram.searchnext

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: QrsTangramInputSignals, TangramOutput

### quality_titles

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AlternativeTitlesInfo

### quality_twiddler

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: BardFilterTwiddlerData, DomainClassification, PlannedRetrievalAnnotations, RankBrainTwiddlerResultAnnotation

### quality_webanswers

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: AnswerList, LongAnswer, QueryInfo, RelatedQuestion, Sensitivity, TriggerInfo, WholeDocAnswer

### quality_webanswers.aquarium

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PrecomputedInputsResult

### quality_webanswers.breadth_first_srp

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: BreadthFirstSrpInfo, ListItem

### quality_webanswers.translated_questions

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TranslatedQuestionsSignals

### quality_webanswers.wafer

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: WaferDebug

### query_result_service

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LogPayloadComplianceReceipt

### ranklab

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: FieldR, MessageR

### repository_webref

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: QueryJoin

### richsnippets

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ReviewSummary

### rpcreplay

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: ArrValidationFieldOptionR, RpcreplayFieldOptionsR, SetRegexToValueH, TimeUnitH

### s

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: E1I130M170Q1U1Y1

### search.features.web

- **消息数量**: 1
- **用途**: 功能管理
- **关键消息**: UgcAttributionInfo

### search.llmresult

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SnapOfflineResults

### search.logging.propagation

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: LoggingSensitivity, LoggingSensitivityR

### search.logging.redaction

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RedactionReasonR

### search.next.components.qrs.resultproviders.codelab

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CodelabResult

### search.next.components.qrs.resultproviders.edugraph

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: EduGraphResult

### search.next.components.qrs.resultproviders.localplacetile

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LocalPlaceTileResult

### search.next.magi

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: FreshnessQuerySignals, Info

### search.next.magi.flows.aim

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SpocQuerySignals

### search.next.servers.mars.flows.aim

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TfsInfo

### search.next.servers.mars.flows.sql.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SqlInfoPayload

### search.vertical_server.p4s

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: GeneratedText

### searchbox.protos

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: OnFocusEventTypeR, QueryFeatureTypeB

### social.frontend.boqdashboard.spongedata

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: OverallStatus

### sponge_perf

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: Aggregation, ConfigurationValue, Metric, PerformanceData, Sample

### storage_graph_bfg

- **消息数量**: 13
- **用途**: 功能模块
- **关键消息**: AuthorityFeedbackMetadataH, LegalRequestMetadataH, LivegraphProvenanceMetadataR, LlmDataAccessRestrictionR, LlmPolicyMetadataR, LmsPolicyMetadataR, PolicyMetadataR, PublicInformationMetadataH, RwjPolicyMetadataR, SpiiCertificationR
  - ... 还有 3 个消息

### streetview_serving

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SVVPaintParameters

### structuredsearch

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: Document, SearchResponse

### superroot

- **消息数量**: 15
- **用途**: 功能模块
- **关键消息**: DisplayableWebResultsSignals, FreshnessLoggingSignals, HuvoCreatorPostProfile, LookupKeysSignal, MagiMathSolverClassificationOutputs, QueryLocation, ReissueInfo, ResponseInfo, SearchResultsFeed, SpellCorrectionUtilParams
  - ... 还有 5 个消息

### superroot.ads.intent_drift

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CommercialAndShoppingIntents

### superroot.comments.discover

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DiscoverCommunityDiscussionsResponse

### superroot.dishexploration

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DishExplorationResult

### superroot.education.bloom

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: BloomSkills

### superroot.events

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: EventData, RelatedEntitiesData, ScubedEventsResultMetadata

### superroot.flights

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: FlightsNaturalLanguageSearchResult

### superroot.food.related_places

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RelatedPlaceSet

### superroot.food.reservations

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ReservationAvailabilityResult

### superroot.hotel_search

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: HotelSearchResolverResponseMetadata

### superroot.human_voices

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: HumanVoiceResultInfo

### superroot.image_api

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: ImageDocFeatures, ImageResultSource

### superroot.impls.carrentals.fulfillment

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CarRentalsData

### superroot.impls.incubation_lab.booking_dot_com

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: BookingDotComHotel, BookingDotComResultSet, BookingDotComUserInfo

### superroot.impls.incubation_lab.context_bridge.third_party_realtor

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: ThirdPartyRealEstate, ThirdPartyRealtor

### superroot.impls.jobs.resolution.proto

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: JobRefinementsData, ScoredJobRefinements

### superroot.impls.knowledge.incubationlab.businessagent

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: BusinessAgentData

### superroot.impls.maps.visualsearch.resolution

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: MapsVisualSearchData

### superroot.kefi.geo

- **消息数量**: 8
- **用途**: 功能模块
- **关键消息**: FeatureIdListProto, GeometryCenterProto, ParkingProperties, PppProto, RegionListProto, RelatedEntrances, ThirdPartyRatingProto, VacationRentalInfoProto

### superroot.kefi.geo_ugc

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: EntityReviewPost

### superroot.kefi.local

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: FirstPartyCorroborationResponse, LocalGenAISummariesRequestParams, LocalGenAISummariesResponse, LocalPhotosOfMenuResponse, RestaurantLevelDietaryRestrictionsExtension, ReviewSummariesRequestParams, ScalableJourneyAttributesResponse, SimpleAttributeCitationsResponse, UgcReviewSummaryRequestParams, UgcReviewSummaryResponse

### superroot.kefi.travel

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TravelHeadlineResponse

### superroot.knowledge

- **消息数量**: 7
- **用途**: 功能模块
- **关键消息**: CalculatorResult, DictionaryResponse, JobSalaryResult, LocalTimeResult, SunriseSunsetEventTimes, UnitConverterResult, WeatherResponse

### superroot.knowledge.civics

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ElectionExplicationData

### superroot.knowledge.crisisresponse

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: CrisisAlertPayload

### superroot.knowledge.dictionary.pronounce

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PronunciationOneboxData

### superroot.learnabout

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LearnAboutQueryResult

### superroot.lens

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LensResultLoggingData

### superroot.local

- **消息数量**: 19
- **用途**: 功能模块
- **关键消息**: AggregatedStructuredQuestionsResponseNamedData, FeatureIdNamedData, FiveStarRatingHistogramNamedData, GcidNamedData, LocalContentApiNamedData, LocalGenAISummariesRequestParams, LocalizedCategoriesNamedData, LocalwebResolverResponseMetadata, NameNamedData, PlaceTopicsNamedData
  - ... 还有 9 个消息

### superroot.local.appointments

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: Providers

### superroot.local.c15n

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: Topic

### superroot.local_food_offers

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LocalFoodOffersNamedData

### superroot.location_familiarity

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: LocationFamiliaritySignals

### superroot.magi

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: AspirationalRetrievalResult, CrosslingualInputData, DisambiguationSignals, FreshnessSignals, LensMagiInputContext, LocalnessSignals, MagiImageFeatureData, MagiInput, MagiRewriterSideOutputs, PassageSignals
  - ... 还有 1 个消息

### superroot.onecorpus

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: OneCorpusResult

### superroot.query_result_service

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: MagiFollowups, ResultAttributionType

### superroot.resolution

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: GenerativeRefinementsData, GettingThereResult, GroundTransportationResult, ResolverResponseMetadata, SustainabilityIncentives, WeatherReasoningResponse

### superroot.resolution.data_commons

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DataCommonsResult

### superroot.resolution.testing

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: TestQuerySignals, TestResultField, TestResultSetSignals

### superroot.result_debug

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ResultDebugInfo

### superroot.rwj

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: GenerativeResultData, LocalActivityImageData

### superroot.rwj.topic_clusters

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: RealWorldJourneysTopicResponseMetadata, RealWorldJourneysTopicResult, RwjUserSignals

### superroot.scubed

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: RefinementResponse

### superroot.scubed.geo_food.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: DishResult

### superroot.scubed.tvm

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: MediaEntityInfo

### superroot.searchpromo

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: PromoResults

### superroot.semantic_pathways

- **消息数量**: 6
- **用途**: 功能模块
- **关键消息**: AiTopicsSearchNextSignal, ClusterIdentity, DerivedIntentMetadata, SemanticPathway, SemanticPathwaysGroupAnnotations, SemanticPathwaysMarsTriggeringSignal

### superroot.shopping

- **消息数量**: 22
- **用途**: 功能模块
- **关键消息**: MagiShoppingCarrier, ProductReviewsProsConsResult, PromotionResult, QueryGenerationMetadata, QueryGenerationResult, ShopTheLookTriggeringInfo, ShoppingCategoryKeyFactorsResult, ShoppingComparisonResult, ShoppingMerchantOffers, ShoppingOrganicEvaluatorResult
  - ... 还有 12 个消息

### superroot.shopping.commerce_conversions

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ShoppingConversionsTrackingInfo

### superroot.sv_discover

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: SvDiscoverFeaturesResult

### superroot.travel

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: AdmissionResult, AppointmentAvailabilityResult, GolfCourseAvailabilityResult, HotelsSummarySet

### superroot.travel_directions

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TravelDirectionsResolverResponseMetadata

### superroot.video

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: ContentForwardResultInfo, SegmentResultAnnotation, VideoResultData, VideoResultModelInputs, VideoTopicSummaries

### superroot.web

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: DocInfoResponse, ParameterizedSnippetResponse, SqueryValidationResponse, VideoTranscriptSentences

### superroot.webanswers

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: ListContextItemPassages

### superroot_logging

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: TwiddlerResultIdentifier

### tensorflow

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: Features

### time

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: AltitueRecommendationToastCount

### twiddler

- **消息数量**: 3
- **用途**: 功能模块
- **关键消息**: DemotedResult, HeavilySpamDemotedResults, SiteBoostSpamQueryInfo

### udr.proto

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: UdrAttachment

### universalsearch

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: RankedJustificationsParams, ThirdPartyMessagingResponse

### universalsearch.local_signals

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: LogsQPData, TfxQueryClickSignals

### universalsearch.new_packer

- **消息数量**: 5
- **用途**: 功能模块
- **关键消息**: WebImageResultDocInfo, WebResultScores, WebResultSnippet, WebResultTopLevelTitle, WebResultUrlSet

### universalsearch.ranking

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: HotelsLogsQPData

### universalsearch.ranking.newpacker.web.signals

- **消息数量**: 1
- **用途**: 功能模块
- **关键消息**: WebImageData

### universalsearch.rpc.geo

- **消息数量**: 10
- **用途**: 功能模块
- **关键消息**: FoodOffersResponse, LastMileGuidanceInfo, LastMileGuidanceRequestParams, LlmTopicClustersResponse, LocalThirdPartyUgcsPostsSearchParams, ReasonsToVisitResponse, TastyMapsLists, TravelVideoResponse, VenueEventsResponse, WhenToVisitResponse

### usersettings

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: GeographicRegion, GeographicScales, Industries, PrimaryUse

### validator

- **消息数量**: 4
- **用途**: 功能模块
- **关键消息**: DefinitionsR, FieldValidationRuleR, OneOfGroupR, OneOfValidationRuleR

### velour

- **消息数量**: 2
- **用途**: 功能模块
- **关键消息**: ApiCompatInfoR, VelourCompatInfoR

### webserver.gws

- **消息数量**: 12
- **用途**: 功能模块
- **关键消息**: BlobIncrementR, BlobPostProcessR, BlobR, BlobSetR, BlobStateR, BlobTypeR, ClientDataHeaderB, ClientVersionInfoR, DevicePropertiesR, IncrementTypeR
  - ... 还有 2 个消息

### wireless.android.privacy

- **消息数量**: 11
- **用途**: 功能模块
- **关键消息**: CollectionBasisAndSpecH, CollectionBasisAndSpecR, CollectionBasisB, CollectionBasisH, CollectionBasisOrSpecH, CollectionBasisOrSpecR, CollectionUseCaseR, EligibleUseCaseB, EligibleUseCaseR, FieldAnnotationR
  - ... 还有 1 个消息

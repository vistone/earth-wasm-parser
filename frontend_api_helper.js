/**
 * Earth WASM 前端 API 辅助库
 * 
 * 用途：提供简单易用的函数来调用 Earth WASM 接口
 */

class EarthWasmAPI {
  constructor(module) {
    this.module = module;
  }

  /**
   * 发送鼠标按下事件
   * @param {number} x - X 坐标
   * @param {number} y - Y 坐标
   * @param {number} button - 按钮 (0=无, 1=左键, 4=释放)
   */
  sendMouseDown(x, y, button = 1) {
    const data = this._encodeInputEvent(1, x, y, button);
    this.module.ReceiveViewModelCommand('earth.InputEvent', data);
  }

  /**
   * 发送鼠标移动事件
   * @param {number} x - X 坐标
   * @param {number} y - Y 坐标
   */
  sendMouseMove(x, y) {
    const data = this._encodeInputEvent(3, x, y, 0);
    this.module.ReceiveViewModelCommand('earth.InputEvent', data);
  }

  /**
   * 发送鼠标释放事件
   * @param {number} x - X 坐标
   * @param {number} y - Y 坐标
   */
  sendMouseUp(x, y) {
    const data = this._encodeInputEvent(2, x, y, 4);
    this.module.ReceiveViewModelCommand('earth.InputEvent', data);
  }

  /**
   * 发送滚轮事件
   * @param {number} x - X 坐标
   * @param {number} y - Y 坐标
   * @param {number} deltaX - 滚轮 X 增量
   * @param {number} deltaY - 滚轮 Y 增量
   */
  sendWheel(x, y, deltaX, deltaY) {
    const buf = new ArrayBuffer(46);
    const view = new DataView(buf);
    const arr = new Uint8Array(buf);
    
    arr[0] = 18; arr[1] = 44;
    arr[2] = 8; arr[3] = 1;
    arr[4] = 16; arr[5] = 0;
    arr[6] = 24; arr[7] = 4;
    arr[8] = 41;
    view.setFloat64(9, x, true);
    arr[17] = 49;
    view.setFloat64(18, y, true);
    arr[26] = 57;
    view.setFloat64(27, deltaX, true);
    arr[35] = 65;
    view.setFloat64(36, deltaY, true);
    arr[44] = 80; arr[45] = 1;
    
    this.module.ReceiveViewModelCommand('earth.InputEvent', arr);
  }

  /**
   * 搜索地点
   * @param {string} query - 搜索关键词
   * @param {Object} options - 选项
   * @param {Object} options.viewport - 视口范围 {north, south, east, west}
   * @param {boolean} options.suppressFlyTo - 是否不飞向结果
   */
  search(query, options = {}) {
    // 实现 PerformSearch 编码
    console.log('搜索:', query, options);
  }

  /**
   * 飞向指定位置
   * @param {Object} position - 位置信息
   * @param {number} position.latitude - 纬度
   * @param {number} position.longitude - 经度
   * @param {number} position.altitude - 高度
   * @param {number} position.range - 视距
   * @param {number} position.heading - 方位角
   * @param {number} position.tilt - 倾斜角
   * @param {string} animation - 动画类型 ('teleport' | 'fly')
   */
  flyTo(position, animation = 'fly') {
    // 实现 FlyToCamera 编码
    console.log('飞向:', position, animation);
  }

  /**
   * 调整视口大小
   * @param {number} width - 宽度
   * @param {number} height - 高度
   */
  resizeViewport(width, height) {
    if (this.module.ResizeViewport) {
      this.module.ResizeViewport(width, height);
    }
  }

  /**
   * 切换图层
   * @param {number} layerType - 图层类型
   * @param {boolean} enabled - 是否启用
   */
  toggleLayer(layerType, enabled) {
    // 实现 ToggleLayer 编码
    console.log('切换图层:', layerType, enabled);
  }

  /**
   * 创建点标记
   * @param {Object} position - 位置
   * @param {number} position.latitude - 纬度
   * @param {number} position.longitude - 经度
   * @param {number} position.altitude - 高度
   */
  createPlacemark(position) {
    // 实现 CreatePointPlacemark 编码
    console.log('创建标记:', position);
  }

  /**
   * 进入时间机器模式
   * @param {string} date - 日期 (YYYY-MM-DD)
   * @param {boolean} timelapseEnabled - 启用时间流逝
   */
  enterTimeMachine(date, timelapseEnabled = true) {
    // 实现 EnterTimeMachine 编码
    console.log('时间机器:', date, timelapseEnabled);
  }

  /**
   * 内部方法：编码 InputEvent
   */
  _encodeInputEvent(type, x, y, button) {
    const buf = new ArrayBuffer(28);
    const view = new DataView(buf);
    const arr = new Uint8Array(buf);
    
    arr[0] = 18; arr[1] = 26;
    arr[2] = 8; arr[3] = 1;
    arr[4] = 16; arr[5] = button;
    arr[6] = 24; arr[7] = type;
    arr[8] = 32; arr[9] = 0;
    arr[10] = 41;
    view.setFloat64(11, x, true);
    arr[19] = 49;
    view.setFloat64(20, y, true);
    
    return arr;
  }
}

// 导出
if (typeof module !== 'undefined' && module.exports) {
  module.exports = EarthWasmAPI;
}


const fs = require('fs');

console.log('=== WASM Protobuf 完整分析 ===\n');

// 1. 分析 earth.InputEvent
console.log('1. earth.InputEvent 消息结构:');
console.log('字段映射:');
console.log('  field 1: bool (varint) - 标志位');
console.log('  field 2: int32 (varint) - 按钮状态 (0/1/2/4)');
console.log('  field 3: int32 (varint) - 事件类型 (1=mousedown, 2=mouseup, 3=mousemove, 4=wheel)');
console.log('  field 4: int32 (varint) - 未知标志');
console.log('  field 5: double (64-bit) - X 坐标');
console.log('  field 6: double (64-bit) - Y 坐标');
console.log('  field 7: double (64-bit) - Delta X (仅 wheel)');
console.log('  field 8: double (64-bit) - Delta Y (仅 wheel)');
console.log('  field 10: bool (varint) - 未知标志');

// 2. 分析初始化参数
console.log('\n2. 初始化参数结构:');
const base64Init = 'GgpFbXNjcmlwdGVuKgV6aF9DTjInQUl6YVN5RDhKYTVBSUlpSFZtZ0RBTmhwNXlnT0FrYklpMmhCWjVBWAFgAXgBgAEBkgEJMTAuOTEuMC4xqAEBsgEnQUl6YVN5QUFqWEY4dHRvRWlVMkdZU3dtUkJ2aU8wdHdVODNGa3lB';
const initBuffer = Buffer.from(base64Init, 'base64');
console.log('  长度:', initBuffer.length);
console.log('  包含:', '"Emscripten", API Key, 版本号');

// 3. 分析配置文件
console.log('\n3. 配置文件结构:');
const configBase64 = fs.readFileSync('wasm/config.base64', 'utf8').trim();
const configBuffer = Buffer.from(configBase64, 'base64');
console.log('  长度:', configBuffer.length);

// 提取可读字符串
const strings = [];
for (let i = 0; i < configBuffer.length; i++) {
  if (configBuffer[i] >= 32 && configBuffer[i] <= 126) {
    let str = '';
    let j = i;
    while (j < configBuffer.length && configBuffer[j] >= 32 && configBuffer[j] <= 126) {
      str += String.fromCharCode(configBuffer[j]);
      j++;
    }
    if (str.length > 5 && str !== strings[strings.length - 1]) {
      strings.push(str);
    }
    i = j;
  }
}

console.log('  找到的服务:');
strings.forEach(s => {
  if (s.includes('service') || s.includes('Service')) {
    console.log(`    - ${s}`);
  }
});

// 4. 查找其他消息类型
console.log('\n4. 其他 Protobuf 消息类型:');
const pluginsContent = fs.readFileSync('wasm/plugins_compiled.js', 'utf8');
const messageTypes = pluginsContent.match(/wireless_android_play_playlog\.[A-Z][a-zA-Z]+/g);
if (messageTypes) {
  const unique = [...new Set(messageTypes)];
  console.log('  找到的消息类型:');
  unique.forEach(m => console.log(`    - ${m}`));
}

console.log('\n5. 总结:');
console.log('  - earth.InputEvent: 输入事件（鼠标）');
console.log('  - wireless_android_play_playlog.*: Play 日志消息');
console.log('  - 配置消息: 包含多个服务配置');
console.log('  - 初始化消息: 包含 API Key 和版本信息');

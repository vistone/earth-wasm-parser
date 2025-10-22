const fs = require('fs');

console.log('=== WASM 文件分析 ===\n');

// 1. 分析 WASM 导出
async function analyzeWasm() {
  const wasmBuffer = fs.readFileSync('wasm/earthplugin_web.wasm');
  const wasmModule = await WebAssembly.compile(wasmBuffer);
  const exports = WebAssembly.Module.exports(wasmModule);
  
  console.log('WASM 导出函数数:', exports.filter(e => e.kind === 'function').length);
  console.log('总导出数:', exports.length);
}

// 2. 分析 JS 文件中的 Module 函数
function analyzeModuleFunctions() {
  const jsContent = fs.readFileSync('wasm/earthplugin_web.js', 'utf8');
  
  // 查找 Module["xxx"] 或 Module.xxx 赋值
  const moduleAssignments = jsContent.match(/Module\[["']([^"']+)["']\]\s*=\s*\w+|Module\.(\w+)\s*=\s*\w+/g) || [];
  
  console.log('\n=== Module 对象函数 ===');
  const funcs = new Set();
  moduleAssignments.forEach(line => {
    const match = line.match(/Module\[["']([^"']+)["']\]|Module\.(\w+)/);
    if (match) {
      const name = match[1] || match[2];
      if (name && !name.match(/^\d+$/)) {
        funcs.add(name);
      }
    }
  });
  
  console.log('找到', funcs.size, '个 Module 函数');
  Array.from(funcs).sort().forEach(f => console.log('  -', f));
}

// 3. 分析 Protobuf 消息
function analyzeProtobuf() {
  const pluginsContent = fs.readFileSync('wasm/plugins_compiled.js', 'utf8');
  
  // 查找可能的 Protobuf 消息字段
  const protoFields = pluginsContent.match(/\d+\s*:\s*function\([^)]*\)/g) || [];
  
  console.log('\n=== Protobuf 消息 ===');
  console.log('找到', protoFields.length, '个可能的消息字段处理函数');
  
  // 查找具体的消息类型
  const messageTypes = pluginsContent.match(/MessageType:\s*(\w+)|type:\s*["']([^"']+)["']/g) || [];
  console.log('找到', messageTypes.length, '个消息类型引用');
}

// 4. 分析 ReceiveViewModelCommand 调用
function analyzeViewModelCommand() {
  const pluginsContent = fs.readFileSync('wasm/plugins_compiled.js', 'utf8');
  
  console.log('\n=== ReceiveViewModelCommand 使用 ===');
  const matches = pluginsContent.match(/ReceiveViewModelCommand[^\n]*/g) || [];
  console.log('找到', matches.length, '处调用');
  matches.forEach((m, i) => {
    console.log(`${i+1}. ${m.substring(0, 100)}`);
  });
}

// 5. 分析 Protobuf 编码格式
function analyzeEncoding() {
  console.log('\n=== Protobuf 编码分析 ===');
  
  // 从 ed1855b 版本的 earth_viewer.dart 中提取的编码信息
  const encodings = {
    'mousedown': { size: 28, fields: ['button state', 'type=1'] },
    'mousemove': { size: 26, fields: ['no button', 'type=3'] },
    'mouseup': { size: 28, fields: ['button state=4', 'type=2'] },
    'wheel': { size: 46, fields: ['type=4', 'deltaX', 'deltaY'] }
  };
  
  console.log('已知的鼠标事件编码格式:');
  Object.entries(encodings).forEach(([event, info]) => {
    console.log(`  ${event}: ${info.size} 字节`);
    info.fields.forEach(f => console.log(`    - ${f}`));
  });
}

analyzeWasm();
analyzeModuleFunctions();
analyzeProtobuf();
analyzeViewModelCommand();
analyzeEncoding();

console.log('\n=== 分析完成 ===');

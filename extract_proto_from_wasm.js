const fs = require('fs');

console.log('=== 从 WASM 文件提取 Protobuf 定义 ===\n');

const wasmBuffer = fs.readFileSync('wasm/earthplugin_web.wasm');

console.log('WASM 文件大小:', wasmBuffer.length, 'bytes');
console.log('');

// 查找所有可打印字符串
console.log('1. 查找所有可打印字符串（至少 10 个字符）:');
const strings = [];
for (let i = 0; i < wasmBuffer.length - 10; i++) {
  let str = '';
  let j = i;
  let printable = 0;
  
  while (j < wasmBuffer.length && printable < 100) {
    const byte = wasmBuffer[j];
    if (byte >= 32 && byte <= 126) {
      str += String.fromCharCode(byte);
      printable++;
      j++;
    } else {
      break;
    }
  }
  
  if (str.length >= 10 && str !== strings[strings.length - 1]) {
    strings.push(str);
  }
}

// 查找包含 proto 相关的字符串
console.log('\n2. 查找 Protobuf 相关字符串:');
const protoStrings = strings.filter(s => 
  s.includes('proto') || 
  s.includes('message') || 
  s.includes('Message') ||
  s.includes('protobuf') ||
  s.includes('field') ||
  s.match(/earth\.[A-Z]/) ||
  s.match(/^\w+\.\w+$/)
);

console.log(`找到 ${protoStrings.length} 个相关字符串:`);
protoStrings.forEach(s => console.log(`  ${s}`));

// 查找特定的消息类型
console.log('\n3. 查找地球相关的消息类型:');
const earthTypes = strings.filter(s => 
  s.includes('earth.') || 
  s.includes('Earth') ||
  s.includes('InputEvent') ||
  s.includes('ViewModel')
);

earthTypes.forEach(s => console.log(`  ${s}`));

console.log('\n4. 尝试查找 Protobuf 描述符:');
// Protobuf 描述符通常包含特定的二进制模式
const descriptorPattern = Buffer.from([0x0a, 0x0c, 0x65, 0x6e, 0x75, 0x6d]); // "enum"
let found = 0;
for (let i = 0; i < wasmBuffer.length - descriptorPattern.length; i++) {
  let match = true;
  for (let j = 0; j < descriptorPattern.length; j++) {
    if (wasmBuffer[i + j] !== descriptorPattern[j]) {
      match = false;
      break;
    }
  }
  if (match) {
    console.log(`  在偏移 ${i} 找到可能的描述符`);
    found++;
    if (found > 5) break;
  }
}

// 输出前 100 个最长的字符串
console.log('\n5. 前 100 个最长的字符串:');
strings.sort((a, b) => b.length - a.length).slice(0, 100).forEach(s => {
  if (s.length > 5) console.log(`  [${s.length}] ${s.substring(0, 100)}`);
});

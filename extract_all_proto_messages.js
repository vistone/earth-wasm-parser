const fs = require('fs');

const wasmBuffer = fs.readFileSync('wasm/earthplugin_web.wasm');

console.log('=== 提取所有 Protobuf 消息类型 ===\n');

// 提取所有消息类型模式
const protoPatterns = [
  /([a-z_]+)\.([A-Z][a-zA-Z0-9_]*)/g,
  /protobuf\.([A-Z][a-zA-Z0-9_]*)/g,
  /google\.protobuf\.([A-Z][a-zA-Z0-9_]*)/g,
];

const allStrings = [];

// 提取所有字符串
for (let i = 0; i < wasmBuffer.length - 5; i++) {
  let str = '';
  let j = i;
  while (j < wasmBuffer.length && wasmBuffer[j] >= 32 && wasmBuffer[j] <= 126) {
    str += String.fromCharCode(wasmBuffer[j]);
    j++;
  }
  if (str.length >= 5) {
    allStrings.push(str);
  }
  i = j;
}

const protoMessages = new Set();

// 查找 Protobuf 消息类型
allStrings.forEach(s => {
  // 查找 pattern: namespace.MessageName
  const match1 = s.match(/^([a-z_]+)\.([A-Z][a-zA-Z0-9_]*)$/);
  if (match1) {
    protoMessages.add(s);
  }
  
  // 查找 google.protobuf.*
  const match2 = s.match(/google\.protobuf\.([A-Z][a-zA-Z0-9_]*)/);
  if (match2) {
    protoMessages.add(s);
  }
  
  // 查找 protobuf.*
  const match3 = s.match(/^protobuf\.([A-Z][a-zA-Z0-9_]*)$/);
  if (match3) {
    protoMessages.add(s);
  }
});

console.log(`找到 ${protoMessages.size} 个 Protobuf 消息类型:\n`);

// 按命名空间分组
const namespaces = {};
protoMessages.forEach(msg => {
  const parts = msg.split('.');
  const ns = parts.slice(0, -1).join('.');
  const name = parts[parts.length - 1];
  
  if (!namespaces[ns]) {
    namespaces[ns] = [];
  }
  namespaces[ns].push(name);
});

Object.keys(namespaces).sort().forEach(ns => {
  console.log(`${ns}:`);
  namespaces[ns].sort().forEach(name => {
    console.log(`  - ${name}`);
  });
  console.log('');
});

// 统计
console.log('\n总计:');
console.log(`  命名空间: ${Object.keys(namespaces).length}`);
console.log(`  消息类型: ${protoMessages.size}`);

const fs = require('fs');

console.log('=== 搜索所有 Protobuf 消息类型 ===\n');

// 搜索所有文件中的消息类型
const files = [
  'wasm/earthplugin_web.js',
  'wasm/plugins_compiled.js',
  'wasm/local_file_system_compiled.js'
];

files.forEach(file => {
  console.log(`\n分析文件: ${file}`);
  console.log('='.repeat(60));
  
  const content = fs.readFileSync(file, 'utf8');
  
  // 查找可能的 Protobuf 消息类型
  const protoPatterns = [
    /(earth|geo|input|command|event|config|message)\.[A-Z][a-zA-Z]*/g,
    /["']([a-z_]+\.[A-Z][a-zA-Z]+)["']/g,
    /MessageType:\s*(["'])([^"']+)\1/g,
    /type:\s*(["'])([^"']+)\1/g
  ];
  
  const types = new Set();
  
  protoPatterns.forEach(pattern => {
    const matches = content.match(pattern);
    if (matches) {
      matches.forEach(m => {
        const extracted = m.match(/["']?([a-z_.A-Z]+)["']?/);
        if (extracted && extracted[1]) {
          types.add(extracted[1]);
        }
      });
    }
  });
  
  console.log(`找到 ${types.size} 个可能的消息类型:`);
  Array.from(types).sort().forEach(t => console.log(`  - ${t}`));
  
  // 查找 ReceiveViewModelCommand 的调用
  const commandMatches = content.match(/ReceiveViewModelCommand\([^)]*\)/g);
  if (commandMatches) {
    console.log(`\nReceiveViewModelCommand 调用:`);
    commandMatches.forEach((m, i) => {
      if (i < 10) console.log(`  ${i+1}. ${m.substring(0, 100)}`);
    });
  }
  
  // 查找可能的 Protobuf 字段编号
  const fieldMatches = content.match(/field\s*(\d+)|字段\s*(\d+)/gi);
  if (fieldMatches) {
    console.log(`\n找到 ${fieldMatches.length} 个字段引用`);
  }
});

console.log('\n\n=== 深度分析 plugins_compiled.js ===\n');
const pluginsContent = fs.readFileSync('wasm/plugins_compiled.js', 'utf8');

// 查找所有字符串字面量（可能是消息类型）
const stringLiterals = pluginsContent.match(/["']([a-z_]+\.[A-Z][a-zA-Z_]+)["']/g);
if (stringLiterals) {
  const unique = new Set(stringLiterals.map(s => s.match(/["']([^"']+)["']/)[1]));
  console.log('找到的消息类型字符串:');
  Array.from(unique).sort().forEach(s => console.log(`  - ${s}`));
}

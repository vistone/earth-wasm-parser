const fs = require('fs');

async function analyzeWasm() {
  console.log('开始分析 WASM 文件...\n');
  
  // 读取 WASM 文件
  const wasmBuffer = fs.readFileSync('wasm/earthplugin_web.wasm');
  console.log('WASM 文件大小:', wasmBuffer.length, 'bytes');
  console.log('WASM 魔数:', wasmBuffer.slice(0, 4).toString('hex'), '(应该是 0061736d)\n');
  
  // 编译 WASM 模块
  const wasmModule = await WebAssembly.compile(wasmBuffer);
  
  // 获取导入
  console.log('=== WASM 导入的函数 (需要从 JS 提供) ===');
  const imports = WebAssembly.Module.imports(wasmModule);
  const importGroups = {};
  imports.forEach(imp => {
    if (!importGroups[imp.module]) {
      importGroups[imp.module] = [];
    }
    importGroups[imp.module].push({
      name: imp.name,
      kind: imp.kind
    });
  });
  
  for (const [module, funcs] of Object.entries(importGroups)) {
    console.log(`\n模块: ${module}`);
    funcs.forEach(f => {
      console.log(`  ${f.kind}: ${f.name}`);
    });
  }
  
  // 获取导出
  console.log('\n\n=== WASM 导出的函数 (可在 JS 中调用) ===');
  const exports = WebAssembly.Module.exports(wasmModule);
  const functionExports = [];
  const memoryExports = [];
  const tableExports = [];
  const globalExports = [];
  
  exports.forEach(exp => {
    if (exp.kind === 'function') {
      functionExports.push(exp.name);
    } else if (exp.kind === 'memory') {
      memoryExports.push(exp.name);
    } else if (exp.kind === 'table') {
      tableExports.push(exp.name);
    } else if (exp.kind === 'global') {
      globalExports.push(exp.name);
    }
  });
  
  console.log(`\n函数导出 (${functionExports.length}个):`);
  functionExports.sort().forEach((name, index) => {
    console.log(`  ${index + 1}. ${name}`);
  });
  
  if (memoryExports.length > 0) {
    console.log(`\n内存导出 (${memoryExports.length}个):`);
    memoryExports.forEach(name => console.log(`  - ${name}`));
  }
  
  if (tableExports.length > 0) {
    console.log(`\n表导出 (${tableExports.length}个):`);
    tableExports.forEach(name => console.log(`  - ${name}`));
  }
  
  if (globalExports.length > 0) {
    console.log(`\n全局变量导出 (${globalExports.length}个):`);
    globalExports.forEach(name => console.log(`  - ${name}`));
  }
  
  console.log('\n\n=== 分析完成 ===');
  console.log(`总导出数: ${exports.length}`);
  console.log(`函数导出数: ${functionExports.length}`);
}

analyzeWasm().catch(console.error);


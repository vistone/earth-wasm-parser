const fs = require('fs');

// 解码初始化参数
const base64Init = 'GgpFbXNjcmlwdGVuKgV6aF9DTjInQUl6YVN5RDhKYTVBSUlpSFZtZ0RBTmhwNXlnT0FrYklpMmhCWjVBWAFgAXgBgAEBkgEJMTAuOTEuMC4xqAEBsgEnQUl6YVN5QUFqWEY4dHRvRWlVMkdZU3dtUkJ2aU8wdHdVODNGa3lB';
const buffer = Buffer.from(base64Init, 'base64');

console.log('=== 初始化参数 Protobuf 分析 ===');
console.log('Length:', buffer.length);
console.log('Hex:', buffer.toString('hex'));
console.log('');

// 简单的十六进制转 ASCII 尝试
console.log('尝试提取字符串:');
for (let i = 0; i < buffer.length; i++) {
  if (buffer[i] >= 32 && buffer[i] <= 126) {
    let str = '';
    let j = i;
    while (j < buffer.length && buffer[j] >= 32 && buffer[j] <= 126) {
      str += String.fromCharCode(buffer[j]);
      j++;
    }
    if (str.length > 3) {
      console.log(`Offset ${i}: "${str}"`);
      i = j;
    }
  }
}

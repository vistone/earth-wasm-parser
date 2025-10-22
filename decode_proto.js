const fs = require('fs');

// 读取配置文件
const configBase64 = fs.readFileSync('wasm/config.base64', 'utf8').trim();
const configBuffer = Buffer.from(configBase64, 'base64');

console.log('=== 配置文件分析 ===');
console.log('Base64 长度:', configBase64.length);
console.log('二进制长度:', configBuffer.length);
console.log('');

// 解析 Protobuf 格式
function parseProtobuf(buffer, offset = 0, indent = '') {
  const result = [];
  let pos = offset;
  
  while (pos < buffer.length) {
    // 读取 tag (field number + wire type)
    const tag = buffer[pos++];
    const fieldNumber = tag >>> 3;
    const wireType = tag & 0x7;
    
    let value;
    let length;
    
    switch (wireType) {
      case 0: // Varint
        value = readVarint(buffer, pos);
        pos = value.nextPos;
        value = value.value;
        console.log(`${indent}Field ${fieldNumber} (Varint): ${value} (0x${value.toString(16)})`);
        break;
        
      case 1: // 64-bit
        value = buffer.readDoubleLE(pos);
        pos += 8;
        console.log(`${indent}Field ${fieldNumber} (64-bit): ${value}`);
        break;
        
      case 2: // Length-delimited
        length = readVarint(buffer, pos);
        pos = length.nextPos;
        length = length.value;
        const bytes = buffer.slice(pos, pos + length);
        pos += length;
        
        console.log(`${indent}Field ${fieldNumber} (Length-delimited, ${length} bytes):`);
        // 尝试解析为子消息
        try {
          parseProtobuf(bytes, 0, indent + '  ');
        } catch (e) {
          // 可能是字符串
          try {
            const str = bytes.toString('utf8');
            if (str.match(/^[\x20-\x7E]*$/)) {
              console.log(`${indent}  (string): "${str}"`);
            } else {
              console.log(`${indent}  (bytes): ${bytes.toString('hex')}`);
            }
          } catch (e2) {
            console.log(`${indent}  (bytes): ${bytes.toString('hex')}`);
          }
        }
        break;
        
      case 5: // 32-bit
        value = buffer.readFloatLE(pos);
        pos += 4;
        console.log(`${indent}Field ${fieldNumber} (32-bit): ${value}`);
        break;
        
      default:
        console.log(`${indent}Field ${fieldNumber} (Unknown wire type ${wireType})`);
        break;
    }
  }
  
  return result;
}

function readVarint(buffer, offset) {
  let value = 0;
  let shift = 0;
  let pos = offset;
  
  while (pos < buffer.length) {
    const byte = buffer[pos++];
    value |= (byte & 0x7F) << shift;
    
    if ((byte & 0x80) === 0) {
      break;
    }
    
    shift += 7;
    if (shift >= 32) {
      throw new Error('Varint too long');
    }
  }
  
  return { value, nextPos: pos };
}

console.log('解析配置文件 Protobuf 消息:');
console.log('');
parseProtobuf(configBuffer);

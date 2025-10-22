const fs = require('fs');

const configBase64 = fs.readFileSync('wasm/config.base64', 'utf8').trim();
const buffer = Buffer.from(configBase64, 'base64');

console.log('=== 配置文件深度 Protobuf 分析 ===\n');
console.log('总长度:', buffer.length, 'bytes');
console.log('');

// 改进的 Protobuf 解析器
function parseProtobuf(buffer, offset = 0, depth = 0, path = '') {
  const indent = '  '.repeat(depth);
  let pos = offset;
  const messages = [];
  
  while (pos < buffer.length) {
    const tag = buffer[pos++];
    const fieldNumber = tag >>> 3;
    const wireType = tag & 0x7;
    
    let value, length;
    
    switch (wireType) {
      case 0: // Varint
        let varintValue = 0;
        let shift = 0;
        while (pos < buffer.length) {
          const byte = buffer[pos++];
          varintValue |= (byte & 0x7F) << shift;
          if ((byte & 0x80) === 0) break;
          shift += 7;
        }
        value = varintValue;
        console.log(`${indent}Field ${fieldNumber} (Varint): ${value}`);
        messages.push({field: fieldNumber, type: 'varint', value});
        break;
        
      case 1: // 64-bit
        value = buffer.readDoubleLE(pos);
        pos += 8;
        console.log(`${indent}Field ${fieldNumber} (Double): ${value}`);
        messages.push({field: fieldNumber, type: 'double', value});
        break;
        
      case 2: // Length-delimited
        let lenShift = 0;
        let lenValue = 0;
        while (pos < buffer.length) {
          const byte = buffer[pos++];
          lenValue |= (byte & 0x7F) << lenShift;
          if ((byte & 0x80) === 0) break;
          lenShift += 7;
        }
        length = lenValue;
        
        const bytes = buffer.slice(pos, pos + length);
        pos += length;
        
        // 尝试解析为子消息
        const subMessages = parseProtobuf(bytes, 0, depth + 1, `${path}.${fieldNumber}`);
        
        if (subMessages.length > 0) {
          console.log(`${indent}Field ${fieldNumber} (Message, ${length} bytes):`);
          messages.push({field: fieldNumber, type: 'message', length, messages: subMessages});
        } else {
          // 尝试作为字符串
          try {
            const str = bytes.toString('utf8');
            if (str.match(/^[\x20-\x7E]*$/)) {
              console.log(`${indent}Field ${fieldNumber} (String, ${length} bytes): "${str}"`);
              messages.push({field: fieldNumber, type: 'string', value: str});
            } else {
              console.log(`${indent}Field ${fieldNumber} (Bytes, ${length} bytes): ${bytes.toString('hex').substring(0, 64)}...`);
              messages.push({field: fieldNumber, type: 'bytes', length});
            }
          } catch (e) {
            console.log(`${indent}Field ${fieldNumber} (Bytes, ${length} bytes): ${bytes.toString('hex').substring(0, 64)}...`);
            messages.push({field: fieldNumber, type: 'bytes', length});
          }
        }
        break;
        
      case 5: // 32-bit
        value = buffer.readFloatLE(pos);
        pos += 4;
        console.log(`${indent}Field ${fieldNumber} (Float): ${value}`);
        messages.push({field: fieldNumber, type: 'float', value});
        break;
        
      default:
        console.log(`${indent}Field ${fieldNumber} (Unknown wire type ${wireType})`);
        break;
    }
  }
  
  return messages;
}

const messages = parseProtobuf(buffer);

console.log('\n\n=== 消息结构总结 ===');
console.log(`总消息数: ${messages.length}`);

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

///md5加密
String generateMD5(String data) {
  Uint8List content = const Utf8Encoder().convert(data);
  Digest digest = md5.convert(content);
  return digest.toString();
}

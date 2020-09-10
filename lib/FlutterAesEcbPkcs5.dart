import 'dart:async';

import 'package:flutter/services.dart';

/// AES ECB PKCS5 encrypt & decrypt.
class FlutterAesEcbPkcs5 {
  static const MethodChannel _channel =
  const MethodChannel('flutter_aes_ecb_pkcs5');

  /// Get device system version.
  ///
  /// * If it is a Android device, like 'Android 9.0'.
  /// * If it is a IOS device, like 'IOS 11.2'.
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Used to generate a specific length of AES key with the given [length].
  ///
  /// If it is a 128-bit key, enter 128 and the returned key will be encoded by Hex.
  /// [value] and [key] shoudn't be null.
  static Future<String> generateDesKey(int length) async {
    try {
      final String result =
      await _channel.invokeMethod('generateDesKey', {"length": length});
      return result;
    } on PlatformException catch (e) {
      throw "Failed to get string encoded: '${e.message}'.";
    }
  }

  /// Encrypts the [txt] with the given [key].
  ///
  /// The result of the encryption will be encoded by HEX.
  /// [txt] and [key] shoudn't be null.
  static Future<String> encryptString(String txt) async {
    try {
      final String result =
      await _channel.invokeMethod('encrypt', {"input": txt, "key": "DA8FD2693B652D587EEE51E7ADD9DBB8"});
      return result;
    } on PlatformException catch (e) {
      throw "Failed to get string encoded: '${e.message}'.";
    }
  }

  /// Decrypts the [txt] with the given [key].
  ///
  /// The content [txt] that needs to be decrypted must be HEX encoded，key also.
  /// [txt] and [key] shoudn't be null.
  static Future<String> decryptString(String txt) async {
    try {
      final String result =
      await _channel.invokeMethod('decrypt', {"input": txt, "key": "DA8FD2693B652D587EEE51E7ADD9DBB8"});
      return result;
    } on PlatformException catch (e) {
      throw "Failed to get string encoded: '${e.message}'.";
    }
  }
}
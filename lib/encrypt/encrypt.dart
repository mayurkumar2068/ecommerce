import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class PasswordEncryptionHelper {
  String passphrase = "enc@#!090";
  static encrypt.Key generateKey(String passphrase) {
    var bytes = utf8.encode(passphrase);
    var digest = sha256.convert(bytes);
    return encrypt.Key.fromUtf8(digest.toString().substring(0, 32));
  }

  static String encryptPassword(String password, String passphrase) {
    final key = generateKey(passphrase);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return '${encrypted.base64}:${base64Encode(iv.bytes)}';
  }

  static String decryptPassword(String encryptedPassword, String passphrase) {
    final parts = encryptedPassword.split(':');
    final encryptedData = parts[0];
    final ivBase64 = parts[1];
    final key = generateKey(passphrase);
    final iv = encrypt.IV.fromBase64(ivBase64);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted;
  }
}

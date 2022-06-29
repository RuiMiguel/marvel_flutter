import 'dart:convert';
import 'package:crypto/crypto.dart';

/// {@template security}
/// Helper to get hash and timestamp for Marvel API server.
/// {@endtemplate}
class Security {
  /// {@macro security}
  Security({
    required String privateKey,
    required String publicKey,
  })  : _privateKey = privateKey,
        _publicKey = publicKey;

  late final String _privateKey;
  late final String _publicKey;

  /// Gets timestamp and hash for that time and keys.
  Map<String, String> hashTimestamp() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5('$timestamp$_privateKey$_publicKey');
    return <String, String>{
      'timestamp': '$timestamp',
      'hash': hash,
    };
  }

  /// Gets MD5 from an input.
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}

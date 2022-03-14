import 'dart:convert';

class Crypt {
  String encode(String username) {
    String credentials = "${username}:";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    return encoded;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<http.Response> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse("https://dummyjson.com/auth/login");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    return response;
  }
}

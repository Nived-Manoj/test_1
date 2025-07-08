import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  static Future<http.Response> fetchProduct() async {
    final url = Uri.parse("https://dummyjson.com/products");
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString('access_token');
    final response =
        await http.get(url, headers: {"Authorization": token.toString()});
    return response;
  }

  static Future<http.Response> serach({required String query}) async {
    final url = Uri.parse("https://dummyjson.com/products/search?q=$query");
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString('access_token');
    final response =
        await http.get(url, headers: {"Authorization": token.toString()});

    return response;
  }

  static Future<http.Response> edit({
    required int id,
    required String title,
  }) async {
    final url = Uri.parse("https://dummyjson.com/products/$id");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final response = await http.put(
      url,
      headers: {
        'Authorization': token != null ? 'Bearer $token' : '',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"title": title}),
    );

    return response;
  }


   static Future<http.Response> delete({
    required int id,
  }) async {
    final url = Uri.parse("https://dummyjson.com/products/$id");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': token != null ? 'Bearer $token' : '',
        'Content-Type': 'application/json',
      },
    
    );
print(response.statusCode);
    return response;
  }



  static Future<http.Response> add({
    required String title,
  }) async {
    final url = Uri.parse("https://dummyjson.com/products/add");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final response = await http.post(
      url,
      headers: {
        'Authorization': token != null ? 'Bearer $token' : '',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"title": title}),
    );
print(response.statusCode);
    return response;
  }
}

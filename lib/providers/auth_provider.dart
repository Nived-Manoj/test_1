import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smbs_test/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  bool get isLoggedIn => token != null;
  String message = "";
  bool isLoading = false;
  // String? get token => _token;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final result =
          await AuthService.login(username: username, password: password);
      print(result.body);
      if (result.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(result.body);

        if (responseBody.containsKey("accessToken")) {
          token = responseBody["accessToken"];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token.toString());

          //Fluttertoast.showToast(msg: "Login successfull");
          Fluttertoast.showToast(msg: "Token is $token");
          isLoading = false;
          notifyListeners();
          return true;
        }
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(result.body);
        isLoading = false;
        Fluttertoast.showToast(msg: "${responseBody["message"]}");
      }
    } catch (e) {
      print(e.toString());
      isLoading = false;
      Fluttertoast.showToast(msg: e.toString());
      notifyListeners();
    }

    return false;
  }
}

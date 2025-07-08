import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smbs_test/models/product_model.dart';
import 'package:smbs_test/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  String message = "";
  String editedTitle = "";
  List<ProductModel>? products;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await ProductService.fetchProduct();

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);

        List<ProductModel> productList = (response['products'] as List)
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();

        products = productList;
        isLoading = false;
        notifyListeners();
      } else {
        message = "Failed to fetch products";
        notifyListeners();
      }
    } catch (e) {
      message = "Something went wrong";
      print("Catch error : ${e.toString()}");
      notifyListeners();
    }
  }

  Future<void> search({required String query}) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await ProductService.serach(query: query);

      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);

        List<ProductModel> productList = (response['products'] as List)
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();

        products = productList;
        isLoading = false;
        notifyListeners();
      } else {
        message = "Failed to fetch products";
        notifyListeners();
      }
    } catch (e) {
      message = "Something went wrong";
      print("Catch error : ${e.toString()}");
      notifyListeners();
    }
  }

  Future<void> edit({required String title, required int id}) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await ProductService.edit(id: id, title: title);
      if (result.statusCode == 200) {
        final Map<String, dynamic> response = jsonDecode(result.body);
        Fluttertoast.showToast(msg: "Edited successfully");
        message = "success";
        isLoading = false;
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Failed to edit product");

        message = "Failed to fetch products";
        notifyListeners();
      }
    } catch (e) {
      message = "Something went wrong";
      print("Catch error : ${e.toString()}");
      Fluttertoast.showToast(msg: "Something went wrong");

      notifyListeners();
    }
  }

   Future<void> delete({ required int id}) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await ProductService.delete(id: id);
      if (result.statusCode == 200) {
        Fluttertoast.showToast(msg: "Deleted successfully");
        message = "success";
        isLoading = false;
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Failed to delete product");

        message = "Failed to delete product";
        notifyListeners();
      }
    } catch (e) {
      message = "Something went wrong";
      print("Catch error : ${e.toString()}");
      Fluttertoast.showToast(msg: "Something went wrong");

      notifyListeners();
    }
  }

  Future<void> add({required String title}) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await ProductService.add(title: title);
      if (result.statusCode == 201) {
        Fluttertoast.showToast(msg: "Product added successfully");
        message = "success";
        isLoading = false;
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Failed to add product");

        notifyListeners();
      }
    } catch (e) {
      message = "Something went wrong";
      print("Catch error : ${e.toString()}");
      Fluttertoast.showToast(msg: "Something went wrong");

      notifyListeners();
    }
  }
}

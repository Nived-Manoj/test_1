import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smbs_test/providers/auth_provider.dart';
import 'package:smbs_test/providers/product_provider.dart';
import 'package:smbs_test/view/login_screen.dart';

void main() {
  runApp(const EcomApp());
}

class EcomApp extends StatelessWidget {
  const EcomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider())
      ],
      child: MaterialApp(
        title: 'SMBS ECommerce',
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}

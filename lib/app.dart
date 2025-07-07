import 'package:flutter/material.dart';
import 'PresentationFeatures/auth/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Compras',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

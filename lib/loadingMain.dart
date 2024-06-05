import 'package:flutter/material.dart';

class loadingMain extends StatelessWidget {
  const loadingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Image.asset('assets/images/logo.jpg'),
    )));
  }
}

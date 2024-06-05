import 'package:flutter/material.dart';

import 'memo.dart';
import 'memoDetail.dart';
import 'newMemo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/memo',
      routes: {
        '/memo': (context) => Memo(),
        '/memoDetail': (context) => MemoDetail(),
        '/newMemo': (context) => NewMemo(),
      },
    );
  }
}

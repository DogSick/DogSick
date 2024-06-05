import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loadingMain.dart';
import 'firstScreen.dart';
import 'memo.dart';
import 'memoDetail.dart';
import 'newMemo.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isOnboarded = prefs.getBool('isOnboarded') ?? false;

    return MaterialApp(
            debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/memo': (context) => Memo(),
        '/memoDetail': (context) => MemoDetail(),
        '/newMemo': (context) => NewMemo(),
      },
    );
  }
}

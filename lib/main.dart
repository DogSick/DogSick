import 'package:dogsick_project/mapMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.env['naver_map_api'];

  String mapId = dotenv.get('naver_map_api');
  await NaverMapSdk.instance.initialize(
    clientId: mapId,
    onAuthFailed: (ex) {
      debugPrint("********* 네이버맵 인증오류 : $ex *********");
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapMain(),
    );
  }
}

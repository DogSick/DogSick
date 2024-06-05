import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'memo.dart';
import 'memoDto.dart';

class MemoDetail extends StatefulWidget {
  const MemoDetail({super.key});

  @override
  State<MemoDetail> createState() => _MemoDetailState();
}

class _MemoDetailState extends State<MemoDetail> {
  final dio = Dio();

  final url = 'http://192.168.0.50:8080/mydog';
  // final url = 'http://10.0.2.2:8080/mydog';
  MemoDTO? memo;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    Future<MemoDTO?> _asyncMemo() async {
      final finalUrl = url + '/' + args.toString();
      final response = await dio.get(finalUrl);

      setState(() {
        memo = MemoDTO.fromJson(response.data?['memo']);
      });

      return memo;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Location',
              style: TextStyle(fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/icon_location.png'),
                Text(
                  '강남구 신사동 115-8',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: _asyncMemo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: Column(
                children: [
                  Text('데이터가 없습니다.'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
            );
          } else {
            return Container(
              margin: EdgeInsets.only(
                top: 60,
                left: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '날짜',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        '${memo?.myDogDate}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Text(
                        '장소',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        '${memo?.myDogLocation}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    '진료 내용',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${memo?.myDogMemo}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff999999),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

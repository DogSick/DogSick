import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Memo extends StatefulWidget {
  const Memo({super.key});

  @override
  State<Memo> createState() => _MemoState();
}

class _MemoState extends State<Memo> {
  final dio = Dio();

  // final url = 'http://192.168.0.50:8080/mydog';
  final url = 'http://10.0.2.2:8080/mydog';
  List? list;

  @override
  void initState() {
    super.initState();
    list = new List.empty(growable: true);
  }

  Future<List?> _asyncList() async {
    final response = await dio.get(url);

    setState(() {
      list = response.data['list'];
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
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
        future: _asyncList(),
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
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 15,
                  ),
                  child: InkWell(
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 80.0,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5,
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${snapshot.data?[index]['myDogDate']}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xffA3AF9E),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${snapshot.data?[index]['myDogLocation']}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff404A3C),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${snapshot.data?[index]['myDogMemo']}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff404A3C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/memoDetail',
                          arguments: list?[index]['myDogCode']);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/newMemo');
        },
        backgroundColor: Color(0xffFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Image.asset('assets/images/vector_write.png'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'searchHospital.dart';
import 'mapMain.dart';
import 'emergency.dart';
import 'memo.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Pretendard'),
        home: Scaffold(
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
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Memo()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.46,
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.all(0),
                        alignment: Alignment(0.7, 0.8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/myrecord.png'),
                              fit: BoxFit.fill
                              )
                            ),
                        child: Text(
                          "MyDog \n 병원기록",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchHospital()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.46,
                        height: MediaQuery.of(context).size.height * 0.4,
                        alignment: Alignment(-0.7, 0.8),
                        margin: EdgeInsets.all(0),
                        child: Text(
                          "병원검색",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/hospitalsearch.png'),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapMain()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.46,
                        height: MediaQuery.of(context).size.height * 0.4,
                        alignment: Alignment(-0.6, 0.8),
                        margin: EdgeInsets.all(0),
                        child: Text(
                          "가까운 병원 검색",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff63C54A)),
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/nearhospital.png'),
                                fit: BoxFit.fill
                            )
                      ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Emergency()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.46,
                        height: MediaQuery.of(context).size.height * 0.3,
                        alignment: Alignment(-0.6, 0.8),
                        margin: EdgeInsets.all(0),
                        child: Text(
                          "응급 상황",
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/emergency.png'),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

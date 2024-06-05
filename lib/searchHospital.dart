import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchHospital extends StatelessWidget {
  const SearchHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                Image.asset('assets/images/Location.png'),
                Text(
                  '강남구 신사동 115-8',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: 315,
              height: 36,
              margin: EdgeInsets.only(left: 50, top: 45, right: 50),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(99, 197, 74, 100)),
                      borderRadius: BorderRadius.circular(15)),
                  hintText: '검색할 병원을 입력하세요',
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(99, 197, 74, 100),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(99, 197, 74, 100)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

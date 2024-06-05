import 'package:flutter/material.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
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
                  )
                ],
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '가장 가까운 동물 병원',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '백산 동물병원',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                  ),
                  Text(
                    '동물병원',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '서울 강남구 논현동86길 22 2층(역삼동)',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '진료중',
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  Text(
                    '00:00 ~ 24:00',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '02-1644-5653',
                    style:
                        TextStyle(fontSize: 14, color: Colors.lightBlueAccent),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: Size(150, 150),
                        shape: CircleBorder()),
                    onPressed: () {},
                    child: Image.asset('assets/images/icon_call.png'),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

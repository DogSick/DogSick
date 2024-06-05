import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';


class MapMain extends StatelessWidget {
  const MapMain({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back), onPressed: () {
        //     print("뒤로가기 버튼 클릭");
        // },
        //   color: Color.fromRGBO(99, 197, 74, 100),
        // ),
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
        body: NaverMap(
          // 카메라 위치 설정
          options: const NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(target: NLatLng(37.506932467450326, 127.05578661133796),
                zoom: 15,
              bearing: 0,
              tilt: 0
            )
          ),
          onMapReady: (controller) {
            print("네이버 맵 로딩됨!");
            // 오버레이 설정(원하는 위치에 마킹)
            final marker = NMarker(id: 'test', position: const NLatLng(37.506932467450326, 127.05578661133796));
            controller.addOverlay(marker);
          },
        ),
    );
  }
}


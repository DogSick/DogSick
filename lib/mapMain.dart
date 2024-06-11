import 'package:dogsick_project/searchHospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'location.dart';

class MapMain extends StatefulWidget {
  MapMain({Key? key}) : super(key: key);

  NaverMapViewOptions options = const NaverMapViewOptions(
    initialCameraPosition: NCameraPosition(target: NLatLng(37.4988, 127.0267), zoom: 16),
    mapType: NMapType.basic,
    locationButtonEnable: true,
  );

  @override
  State<MapMain> createState() => _MapMainState();
}

class _MapMainState extends State<MapMain> {

  bool _showBottomSheet = false;

  String result = "";
  List? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = new List.empty(growable: true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Color.fromRGBO(99, 197, 74, 100),
        ),
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
                Locate(),
              ],
            )
          ],
        ),
        actions: [
          SizedBox(
            width: 60,
          ),
        ],
      ),

      body: Stack(
        children: <Widget>[
        NaverMap(
        // 카메라 위치 설정
        options: const NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(target: NLatLng(37.4988, 127.0267),
              zoom: 16,
              bearing: 0,
              tilt: 0
          ),
          mapType: NMapType.basic,
          activeLayerGroups: [
            NLayerGroup.transit,
            NLayerGroup.building,
          ],
          minZoom: 10,
          maxZoom: 20,
          maxTilt: 30,
          extent: NLatLngBounds(southWest: NLatLng(31.43, 122.37), northEast: NLatLng(44.35, 132.0)),
          locationButtonEnable: true,
          scaleBarEnable: true,
        ),
        onMapReady: (controller) async{
          print("네이버 맵 로딩됨!");
          //

          final locationOverlay = await controller.getLocationOverlay();
          locationOverlay.setPosition(NLatLng(37.4988, 127.0267));
          print(locationOverlay.getPosition());
          // 오버레이 설정(원하는 위치에 마킹)
          final location = NMarker(id: 'location',
            position: const NLatLng(37.4988, 127.0267),
            anchor: const NPoint(0.5, 0.5),
            size: const Size(20, 20),
            // iconTintColor: Colors.green,
            icon: const NOverlayImage.fromAssetImage('assets/images/location_mark.png'),
          );


          final marker = NMarker(id: NLatLng(37.4998, 127.0271).toString(),
            position: const NLatLng(37.4998, 127.0271),
            anchor: const NPoint(0.5, 0.5),
            size: const Size(60, 60),
            // iconTintColor: Colors.green,
            icon: const NOverlayImage.fromAssetImage('assets/images/marker.png'),
          );
          controller.addOverlay(location);
          controller.addOverlay(marker);
          // controller.addOverlayAll(markers)

          marker.setOnTapListener((NMarker marker) {
            // 마커를 클릭했을 때 실행할 코드
            print(marker);
            setState(() {
              this._showBottomSheet = true;
            });
            // this._showBottomSheet = !this._showBottomSheet;
            print(this._showBottomSheet);
          });
        },
          onMapTapped: (NPoint point, NLatLng latLng) {
          // 지도를 클릭했을 때 실행할 코드
            setState(() {
              this._showBottomSheet = false;
            });
            print(this._showBottomSheet);
          },
      ),
      Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButton.icon(
        onPressed: () {

        },
          label: Text('현재 위치에서 재검색', style: TextStyle(color: Colors.black),
          ),
          icon: Icon(Icons.replay_outlined, size: 25, color: Colors.black, textDirection: TextDirection.rtl,),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        ),
        ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: () {  
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchHospital()),);
              },
              child: Text('병원목록', style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xff404a3c),
              ),
            ),
          ),
          this._showBottomSheet
              ? HospitalInfoWidget()
              : Container(),
        ],
      ),
    );
  }
}

class HospitalInfoWidget extends StatelessWidget {
  const HospitalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 50,
      left: 50,
      bottom: 0,
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20),
            ),
          ),
          width: 200,
          height: 100.0,
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ),
        ),
    );
  }
}
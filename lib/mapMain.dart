import 'package:dogsick_project/searchHospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';


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

  String? latitude;
  String? longitude;

  getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }

    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    // setState(() {
    //   latitude.position.latitude.toString();
    //   longitude.position.longitude.toString();
    // });
  }

  bool _showBottomSheet = false;

  String result = "";
  List? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = new List.empty(growable: true);
    getGeoData();
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
                Text(
                  '강남구 신사동 115-8',
                  style: TextStyle(fontSize: 10),
                ),
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


          final marker = NMarker(id: 'position',
            position: const NLatLng(37.4998, 127.0271),
            anchor: const NPoint(0.5, 0.5),
            size: const Size(60, 60),
            // iconTintColor: Colors.green,
            icon: const NOverlayImage.fromAssetImage('assets/images/marker.png'),
          );
          // controller.addOverlay(location);
          controller.addOverlay(marker);
          // controller.addOverlayAll(markers)

          marker.setOnTapListener((NMarker marker) {
            // 마커를 클릭했을 때 실행할 코드
          });
        },
      ),
          this._showBottomSheet
          ? HospitalInfoWidget()
              : Container(),
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
    );
  }
}

class Location {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}

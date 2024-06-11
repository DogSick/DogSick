import 'dart:async';

import 'package:dogsick_project/searchHospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location.dart';

class MapMain extends StatefulWidget {
  MapMain({Key? key}) : super(key: key);

  late SharedPreferences prefs;

  NaverMapViewOptions options = const NaverMapViewOptions(
    initialCameraPosition: NCameraPosition(target: NLatLng(37.4988, 127.0267), zoom: 16),
    mapType: NMapType.basic,
    locationButtonEnable: true,
  );

  @override
  State<MapMain> createState() => _MapMainState();
}

class _MapMainState extends State<MapMain> {
  double? latitude;
  double? longitude;

  bool _showBottomSheet = false;

  @override
  void initState() {
    super.initState();
    getGeoData();
  }

  Future<void> getGeoData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }

    LocationData location = LocationData();
    await location.getCurrentLocation();
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
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
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: latitude != null && longitude != null
                    ? NLatLng(latitude!, longitude!)
                    : NLatLng(37.4988, 127.0267),
                zoom: 16,
                bearing: 0,
                tilt: 0,
              ),
              mapType: NMapType.basic,
              activeLayerGroups: [
                NLayerGroup.transit,
                NLayerGroup.building,
              ],
              minZoom: 10,
              maxZoom: 20,
              maxTilt: 30,
              extent: NLatLngBounds(
                  southWest: NLatLng(31.43, 122.37),
                  northEast: NLatLng(44.35, 132.0)),
              locationButtonEnable: true,
              scaleBarEnable: true,
            ),
            onMapReady: (controller) async {
              print("네이버 맵 로딩됨!");

              if (latitude != null && longitude != null) {
                final locationOverlay = await controller.getLocationOverlay();
                locationOverlay.setPosition(NLatLng(latitude!, longitude!));
                print(locationOverlay.getPosition());

                final location = NMarker(
                  id: 'location',
                  position: NLatLng(latitude!, longitude!),
                  anchor: const NPoint(0.5, 0.5),
                  size: const Size(20, 20),
                  icon: const NOverlayImage.fromAssetImage('assets/images/location_mark.png'),
                );

                final marker = NMarker(
                  id: NLatLng(latitude! + 0.001, longitude! + 0.001).toString(),
                  position: NLatLng(latitude! + 0.001, longitude! + 0.001),
                  anchor: const NPoint(0.5, 0.5),
                  size: const Size(60, 60),
                  icon: const NOverlayImage.fromAssetImage('assets/images/marker.png'),
                );

                controller.addOverlay(location);
                controller.addOverlay(marker);

                marker.setOnTapListener((NMarker marker) {
                  print(marker);
                  setState(() {
                    _showBottomSheet = true;
                  });
                });
              }
            },
            onMapTapped: (NPoint point, NLatLng latLng) {
              setState(() {
                _showBottomSheet = false;
              });
            },
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton.icon(
              onPressed: () {
                getGeoData();
              },
              label: Text(
                '현재 위치에서 재검색',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.replay_outlined,
                size: 25,
                color: Colors.black,
                textDirection: TextDirection.rtl,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchHospital()),
                );
              },
              child: Text(
                '병원목록',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff404a3c),
              ),
            ),
          ),
          _showBottomSheet ? HospitalInfoWidget() : Container(),
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
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: 200,
        height: 100.0,
      ),
    );
  }
}

class LocationData {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
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

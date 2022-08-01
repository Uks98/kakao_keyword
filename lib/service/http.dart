import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:keyword_map/data/data.dart';

class MapApi extends LocationClass{
  List<MapData> mapData = [];
  Future<List<MapData>?> getMapList({required String keyword, required int page}) async {
    var url = "https://dapi.kakao.com/v2/local/search/keyword.json?y=${latitude}&x=${longitude}&radius=20000&query=$keyword&page=$page&sort=distance";
    var response = await http.get(Uri.parse(url), headers: {"Authorization": "KakaoAK 5026bccd6af45144199ef3f70f4b7ec7"});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String,dynamic>;
      for(final _res in res["documents"]){
        final m = MapData.fromJson(_res as Map<String,dynamic>);
        mapData.add(m);
      }
    }
    return mapData;
  }
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}


class LocationClass{
  var longitude;
  var latitude;

  void getLocation(BuildContext context) async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      toastMessage(context,"위치를 허용해주세요");
      LocationPermission per1 = await Geolocator.requestPermission();
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
        toastMessage(context,"현재 위치정보입니다.");
        longitude = currentLoc.longitude;
        latitude = currentLoc.latitude;
        print(longitude);
        print(latitude);
    }
  }
  void toastMessage(BuildContext context,String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

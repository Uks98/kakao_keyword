import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:keyword_map/data/data.dart';

class MapApi {
  List<MapData> mapData = [];
  Future<List<MapData>?> getMapList({required String keyword, required int page}) async {
    var url = "https://dapi.kakao.com/v2/local/search/keyword.json?y=37.514322572335935&x=127.06283102249932&radius=20000&query=$keyword&page=$page&sort=distance";
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
    print(mapData.first.distance);
    return super.toString();
  }

}

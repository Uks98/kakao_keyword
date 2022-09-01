// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:keyword_map/service/http.dart';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  Station({
    required this.documents,
    required this.meta,
  });

  List<Document> documents;
  Meta meta;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Document {
  Document({
    required this.addressName,
    required this.categoryGroupCode,
    required this.categoryGroupName,
    required this.categoryName,
    required this.distance,
    required this.id,
    required this.phone,
    required this.placeName,
    required this.placeUrl,
    required this.roadAddressName,
    required this.x,
    required this.y,
  });

  AddressName? addressName;
  CategoryGroupCode? categoryGroupCode;
  CategoryGroupName? categoryGroupName;
  String? categoryName;
  String? distance;
  String? id;
  String? phone;
  String? placeName;
  String? placeUrl;
  RoadAddressName? roadAddressName;
  String? x;
  String? y;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    addressName: addressNameValues.map[json["address_name"]],
    categoryGroupCode: categoryGroupCodeValues.map[json["category_group_code"]],
    categoryGroupName: categoryGroupNameValues.map[json["category_group_name"]],
    categoryName: json["category_name"],
    distance: json["distance"],
    id: json["id"],
    phone: json["phone"],
    placeName: json["place_name"],
    placeUrl: json["place_url"],
    roadAddressName: roadAddressNameValues.map[json["road_address_name"]],
    x: json["x"],
    y: json["y"],
  );

  Map<String, dynamic> toJson() => {
    "address_name": addressNameValues.reverse![addressName],
    "category_group_code": categoryGroupCodeValues.reverse![categoryGroupCode],
    "category_group_name": categoryGroupNameValues.reverse![categoryGroupName],
    "category_name": categoryName,
    "distance": distance,
    "id": id,
    "phone": phone,
    "place_name": placeName,
    "place_url": placeUrl,
    "road_address_name": roadAddressNameValues.reverse![roadAddressName],
    "x": x,
    "y": y,
  };
}

enum AddressName { THE_858, THE_804, THE_8211 }

final addressNameValues = EnumValues({
  "서울 강남구 역삼동 804": AddressName.THE_804,
  "서울 강남구 역삼동 821-1": AddressName.THE_8211,
  "서울 강남구 역삼동 858": AddressName.THE_858
});

enum CategoryGroupCode { CE7, FD6 }

final categoryGroupCodeValues = EnumValues({
  "CE7": CategoryGroupCode.CE7,
  "FD6": CategoryGroupCode.FD6
});

enum CategoryGroupName { EMPTY, CATEGORY_GROUP_NAME }

final categoryGroupNameValues = EnumValues({
  "음식점": CategoryGroupName.CATEGORY_GROUP_NAME,
  "카페": CategoryGroupName.EMPTY
});

enum RoadAddressName { THE_396, THE_101 }

final roadAddressNameValues = EnumValues({
  "서울 강남구 테헤란로 101": RoadAddressName.THE_101,
  "서울 강남구 강남대로 지하 396": RoadAddressName.THE_396
});

class Location {
  //ItemList => 위도 경도 담고있는 클래스
  List<Document>? mapList;

  Location({required this.mapList});

  Location.fromJson(Map<String, dynamic> json) {
    //해당 키 값에 접근하기 위해 작성
    if (json['documents'] != null) {
      mapList = <Document>[];
      json['documents'].forEach((v) {
        mapList!.add(new Document.fromJson(v));
      });
    }
    print("office : ${mapList}");
  }
}
Future<Location> getGoogleMap(
    {required String keyword}) async {
  var googleLocationsURL = 'https://dapi.kakao.com/v2/local/search/keyword.json?y=${LocationClass.latitude}&x=${LocationClass.longitude}&radius=20000&query=$keyword&page=1&sort=distance';
  final response = await http.get(Uri.parse(googleLocationsURL), headers: {"Authorization": "KakaoAK 5026bccd6af45144199ef3f70f4b7ec7"});
  if (response.statusCode == 200) {
    print("body : ${response.body}");
    //Map<String,dynamic>형식으로 저장
    return Location.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}

class Meta {
  Meta({
    required this.isEnd,
    required this.pageableCount,
    required this.sameName,
    required this.totalCount,
  });

  bool isEnd;
  int pageableCount;
  SameName sameName;
  int totalCount;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    isEnd: json["is_end"],
    pageableCount: json["pageable_count"],
    sameName: SameName.fromJson(json["same_name"]),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "is_end": isEnd,
    "pageable_count": pageableCount,
    "same_name": sameName.toJson(),
    "total_count": totalCount,
  };
}

class SameName {
  SameName({
    required this.keyword,
    required this.region,
    required this.selectedRegion,
  });

  String? keyword;
  List<dynamic> region;
  String? selectedRegion;

  factory SameName.fromJson(Map<String, dynamic> json) => SameName(
    keyword: json["keyword"],
    region: List<dynamic>.from(json["region"].map((x) => x)),
    selectedRegion: json["selected_region"],
  );

  Map<String, dynamic> toJson() => {
    "keyword": keyword,
    "region": List<dynamic>.from(region.map((x) => x)),
    "selected_region": selectedRegion,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

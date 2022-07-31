
class MapData {
  String? id; //해당 장소에 id값
  String? address_name; //주소
  String? categoryName; //카테고리 => 약국,식당..
  String? placeName; //장소 이름
  String? phone; // 해당 장소 번호
  String? x; // 위도
  String? y; // 경도
  String? distance;

  MapData({this.id,
    this.address_name,
    this.categoryName ,
    this.placeName,
    this.phone ,
    this.x ,
    this.y ,
    this.distance});

  factory MapData.fromJson(Map<String,dynamic> data) {
    return MapData(
        id: data["id"].toString(),
        address_name: data["address_name"].toString(),
        categoryName: data["category_group_name"].toString(),
        placeName: data["place_name"].toString(),
        phone: data["phone"].toString(),
        x: data["x"].toString(),
        y: data["y"].toString(),
        distance: data["distance"].toString());
  }
}
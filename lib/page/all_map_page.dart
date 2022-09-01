import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keyword_map/service/http.dart';
import '../data/map_data.dart';
import 'package:keyword_map/data/map_data.dart' as sta;
class AllMapPage extends StatefulWidget {
  String? keyword;
  AllMapPage({Key? key,this.keyword}) : super(key: key);

  @override
  _AllMapPageState createState() => _AllMapPageState();
}

class _AllMapPageState extends State<AllMapPage> {
  int _count = 0;
  MapApi _mapApi = MapApi();
  LocationClass locationClass = LocationClass();
  final Map<String, Marker> _markers = {};
  String get keyword => this.keyword;
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices1 = await sta.getGoogleMap(keyword:"식당");
    setState(() {
      _markers.clear();
      for (final office in googleOffices1.mapList!) {
        final marker = Marker(
          markerId: MarkerId((_count +=1).toString()),
          position: LatLng(double.parse(office.y.toString()), double.parse(office.x.toString())),
        );
        _markers[(_count +=1).toString()] = marker;
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("위도 : ${LocationClass.latitude}");
    print(LocationClass.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Bus 정류장 위치'),
          backgroundColor: Colors.blue[700],
          centerTitle: true,
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          //위치 클래스에서 데이터 null 현상 static 타입으로 변환 후 불러오기 성공!
          initialCameraPosition: CameraPosition(

            target: LatLng(LocationClass.latitude == null ? 37.4979962962006 : LocationClass.latitude,
              LocationClass.longitude == null ? 127.027745796947 : LocationClass.longitude),
            zoom: 16,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
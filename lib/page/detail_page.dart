import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keyword_map/maptile_card.dart';

import '../data/data.dart';

class MapDataPage extends StatefulWidget {
  MapData mapData;

  MapDataPage({Key? key, required this.mapData}) : super(key: key);

  @override
  State<MapDataPage> createState() => _MapDataPageState();
}

class _MapDataPageState extends State<MapDataPage> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = {};
  CameraPosition? _googleMapCamera;
  Marker? marker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleMapCamera = CameraPosition(
      target: LatLng(double.parse(widget.mapData.y.toString()),
          double.parse(widget.mapData.x.toString())),
      zoom: 15,
    );
    MarkerId markerId = MarkerId(widget.mapData.hashCode.toString());
    marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(10.0),
        position: LatLng(double.parse(widget.mapData.y.toString()),
            double.parse(widget.mapData.x.toString())),
        flat: true,
        markerId: markerId);
    markers[markerId] = marker!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mapData.placeName.toString(),
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          googleMap(),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: MapTile(
                mapData: widget.mapData,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget googleMap() {
    return SizedBox(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _googleMapCamera!,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}

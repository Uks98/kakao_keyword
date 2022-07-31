import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keyword_map/service/http.dart';

import '../data/data.dart';
class MapListPage extends StatefulWidget {
  const MapListPage({Key? key}) : super(key: key);

  @override
  State<MapListPage> createState() => _MapListPageState();
}

class _MapListPageState extends State<MapListPage> {
  List<MapData>? mapList = [];
  MapApi mapApi = MapApi();
  void getMapData()async{
    mapList = await mapApi.getMapList(keyword: "약국", page: 1);
    print("맵리스트 : ${mapList}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMapData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getMapData();
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
           Expanded(child: ListView.builder(
              itemCount: mapList?.length,
              itemBuilder: (context,index){
                final i  = mapList![index];
            return ListTile(
              title: Text(i.placeName.toString()),
              subtitle: Text(i.address_name.toString()),
            );
          }))
        ],
      ),
    );
  }

}

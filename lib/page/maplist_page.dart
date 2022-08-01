import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keyword_map/maptile_card.dart';
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
  TextEditingController searchController = TextEditingController();
  void getMapData()async{
    mapList = await mapApi.getMapList(keyword: searchController.text, page: 1);
    setState((){});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapApi.getLocation(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,elevation: 0.5,title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: searchController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(10),
            hintText: "장소 키워드 검색",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
      ),
        ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState((){
          getMapData();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
           searchController.text.isEmpty ? Container(
             child: Center(child: Text("키워드를 입력해주세요"),),
           ):Expanded(child: ListView.builder(
              itemCount: mapList?.length,
              itemBuilder: (context,index){
                final i  = mapList![index];
            return MapTile(mapData: i);
          }))
        ],
      ),
    );
  }

}

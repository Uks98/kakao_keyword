import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keyword_map/maptile_card.dart';
import 'package:keyword_map/page/keep_page.dart';
import 'package:keyword_map/service/http.dart';
import 'package:keyword_map/service/sq_lite.dart';

import '../data/data.dart';

class MapListPage extends StatefulWidget {
  const MapListPage({Key? key}) : super(key: key);

  @override
  State<MapListPage> createState() => _MapListPageState();
}

class _MapListPageState extends State<MapListPage> {
  int page = 1;
  List<MapData>? mapList = [];
  MapApi mapApi = MapApi();
  DatabaseHome databaseHome = DatabaseHome();
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  void getMapData() async {
    mapList = await mapApi.getMapList(
        keyword: searchController.text, page: page, context: context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapApi.getLocation(context);
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        print("bottom");
        page++;
        getMapData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => KeepPage(
                    mapData: MapData(
                      address_name: "김치"
                    ),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: Row(
            children: [
              IconButton(
                  padding: EdgeInsets.only(right: 20),
                  onPressed: (){}, icon: Icon(Icons.map_outlined,color: Colors.grey[800],)),
              Expanded(
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
              ),
              TextButton(
                onPressed: () => setState(
                  () {
                    getMapData();
                  },
                ),
                child: Text(
                  "검색",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          searchController.text.isEmpty
              ? Container(
                  child: Center(
                    child: Text("키워드를 입력해주세요"),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                  itemCount: mapList!.length,
                  itemBuilder: (context, index) {
                    final i = mapList![index];
                    return GestureDetector(
                        onLongPress: () {
                           databaseHome.insertDB(mapList![index]);
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => KeepPage(
                          //       mapData: i,
                          //     ),
                          //   ),
                          // );
                        },
                        child: MapTile(mapData: i));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 1.5,
                      endIndent: 10,
                      indent: 10,
                    );
                  },
                  controller: _scrollController,
                ))
        ],
      ),
    );
  }
}

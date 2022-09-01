import 'package:flutter/material.dart';
import 'package:keyword_map/data/data.dart';
import 'package:keyword_map/service/sq_lite.dart';

class KeepPage extends StatefulWidget {
  MapData? mapData;

  KeepPage({Key? key, this.mapData}) : super(key: key);

  @override
  State<KeepPage> createState() => _KeepPageState();
}

class _KeepPageState extends State<KeepPage> {
  DatabaseHome databaseHome = DatabaseHome();
  Future<List<MapData>>? mapLists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapLists = databaseHome.getMaps();
  }

  @override
  Widget build(BuildContext context) {
    print("${mapLists}맵리스트...............");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text(
          "즐겨찾기",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: mapLists,
                builder: (context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      itemCount:snapshot.data.length,
                      itemBuilder: (context, i) {
                        List<MapData> tourList = snapshot.data as List<MapData>;
                        MapData maps = tourList[i];
                        return ListTile(title: Text(maps.address_name.toString()),);
                      });
                }),
          ),
        ],
      ),
    );
  }
}

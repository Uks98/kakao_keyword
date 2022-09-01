import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/data.dart';

class DatabaseHome {
  MapData mapData = MapData();

  Future<Database> initDB() async {
    return openDatabase(join(await getDatabasesPath(), "mapData.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE mapData(id INTEGER PRIMARY KEY AUTOINCREMENT,address_name TEXT,categoryName TEXT,placeName TEXT, phone TEXT, x TEXT, y TEXT, distance TEXT)");
    }, version: 3);
  }

  void insertDB(MapData data) async {
    Database database = await initDB();
    await database.insert("mapData", mapData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace).then((value) => print("저장완료"));
  }

  Future<List<MapData>> getMaps()async{
    final database = await initDB();
    final maps = await database.query("mapData");
    print("maps : ${maps}");
    return List.generate(maps.length, (index) {
      return MapData(
          id: maps[index]['id'].toString(),
          address_name: maps[index]['address_name'].toString(),
          categoryName: maps[index]['categoryName'].toString(),
          placeName: maps[index]['placeName'].toString(),
          phone: maps[index]['phone'].toString(),
          x: maps[index]['x'].toString(),
          y: maps[index]['y'].toString(),
          distance: maps[index]['distance'].toString());
    });
  }
}

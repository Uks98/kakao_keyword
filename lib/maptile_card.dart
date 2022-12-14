import 'package:flutter/material.dart';
import 'package:keyword_map/page/detail_page.dart';

import 'data/data.dart';

class MapTile extends StatelessWidget {
  MapData mapData;
  MapTile({Key? key, required this.mapData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MapDataPage(
              mapData: mapData,
            ),
          ),
        );
      },
      onDoubleTap: (){

      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    mapData.placeName.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    mapData.categoryName.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "${mapData.distance}m",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    mapData.address_name.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  mapData.phone == ""
                      ? Text(
                          "등록된 번호가 없습니다.",
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueAccent),
                        )
                      : Text(
                          "${mapData.phone}",
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueAccent),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

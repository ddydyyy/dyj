// import 'package:finance/models/kospi.dart';
// import 'package:finance/service/api_service.dart';
// import 'package:flutter/material.dart';
//
// class Graph1 extends StatefulWidget {
//   // final KospiModel kospi;
//
//   const Graph1({
//     super.key,
//     // required this.kospi
//   });
//
//   @override
//   State<Graph1> createState() => _Graph1State();
// }
//
// class _Graph1State extends State<Graph1> {
//   late Future<KospiModel> kospi;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('test'),
//     );
//   }
// }

import 'package:finance/provider/main_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Graph1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kospiProvider = Provider.of<KospiProvider>(context);
    // final kospiProvider = Provider.of<KospiProvider>(context);
    //
    // // fetchKospiData 메서드를 호출하여 데이터를 가져옵니다.
    // if (kospiProvider.kospiData == null) {
    //   kospiProvider.fetchKospiData();
    // }

    return kospiProvider.kospiData == null
        // 로딩 표시
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Text('teststst'),
              Text('기준일: ${kospiProvider.kospiData![0].BAS_DD}'),
              // Text('지수명: ${kospiProvider.kospiData!.IDX_NM}'),
              // Text('종가 지수: ${kospiProvider.kospiData!.CLSPRC_IDX}',),
              // 필요한 데이터들을 추가로 표시
            ],
          );
  }
}

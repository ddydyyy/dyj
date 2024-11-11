// import 'package:finance/service/api_service.dart';
// import 'package:flutter/material.dart';
//
// class DY extends StatefulWidget {
//   @override
//   _DY createState() => _DY();
// }
//
// class _DY extends State<DY> {
//   // final Kospi _kospi = Kospi();
//   final Future<void> _kospi = Kospi();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchKospiData();
//   }
//
//   void _fetchKospiData() async {
//     await _kospi.getKospi();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('KOSPI Data')),
//       body: FutureBuilder(
//         future: _kospi,
//         builder: (context, snapshot) {
//           if(snapshot.hasData) {
//             return Text('성공');
//           }else{
//             return Text('실패');
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';

class DY extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('...'),
    );
  }
}
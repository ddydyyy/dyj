import 'package:finance/service/api_service.dart';
import 'package:flutter/material.dart';

class Graph1 extends StatelessWidget {
  Graph1({super.key});

  Future<Map<String, dynamic>> kospi = KospiService().getKospi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: kospi,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Text('응답 성공');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
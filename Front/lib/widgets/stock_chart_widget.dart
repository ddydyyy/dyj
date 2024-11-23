// widgets/stock_chart_widget.dart

import 'package:finance/services/stock_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockChart extends StatelessWidget {
  final String accessToken;
  final String code;

  const StockChart({
    super.key,
    required this.accessToken,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      // color: Colors.greenAccent,
      child: Column(
        children: [
          SummaryMajorIndex(
            accessToken: accessToken,
            // 코스피(0001), 코스닥(1001), 코스피200(2001) ...
            code : '0001',
          ),
          SummaryStockData(
            accessToken: accessToken,
            code : code,
          ),
          const Text('3'),
          const Text('4'),
        ],
      ),
    );
  }
}

// 주요지수 요약표
class SummaryMajorIndex extends StatelessWidget {
  final String accessToken;
  final String code;

  const SummaryMajorIndex({
    super.key,
    required this.accessToken,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StockService().getMajorIndex(accessToken, code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 로딩 표시
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 에러 표시
              child: Text("Error loading data"),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return SizedBox(
            // color: Colors.grey,
            height: 60,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('123'),
                        // Text('${data.currentPrice}'),
                        // Text('${data.changePrice}'),
                        const Text('주요지수 - KOSPI'),
                        Text('${data.volume}'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('그래프'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${data.price}'),
                        // 가격 56000 -> 56,000 처럼 표시
                        // Text(
                        //   NumberFormat('#,###').format(data.price),
                        // ),
                        Text('${data.changeRate}%',
                          style: TextStyle(
                            color: data.changeRate > 0
                                ? Colors.red
                                : data.changeRate < 0
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // 데이터가 없는 경우의 기본 반환값 추가
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              child: Text("No data available"),
            ),
          );
        }
      },
    );
  }
}

// 보유종목 요약표
class SummaryStockData extends StatelessWidget {
  final String accessToken;
  final String code;

  const SummaryStockData({
    super.key,
    required this.accessToken,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StockService().getStockData(accessToken, code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 로딩 표시
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 에러 표시
              child: Text("Error loading data"),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return SizedBox(
            // color: Colors.grey,
            height: 60,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('123'),
                        // Text('${data.currentPrice}'),
                        // Text('${data.changePrice}'),
                        const Text('개별종목 - 삼성전자'),
                        Text('${data.volume}'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('그래프'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('${data.currentPrice}'),
                        // 가격 56000 -> 56,000 처럼 표시
                        Text(
                          NumberFormat('#,###').format(data.price),
                        ),
                        Text('${data.changeRate}%',
                          style: TextStyle(
                            color: data.changeRate > 0
                                ? Colors.red
                                : data.changeRate < 0
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // 데이터가 없는 경우의 기본 반환값 추가
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              child: Text("No data available"),
            ),
          );
        }
      },
    );
  }
}


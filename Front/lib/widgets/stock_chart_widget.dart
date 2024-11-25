// widgets/stock_chart_widget.dart

import 'package:finance/services/stock_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// EachStockChart(accessToken, code)
// - 추후 보유중인 전체 개별종목 요약표로 사용 예정( SummaryStockData 이용 )
// SummaryMajorIndex(accessToken, code, height)
// - 주요지수 요약표
// SummaryStockData(accessToken, code)
// - 개별종목 요약표

// 보유 중인 전체 개별 종목 요약표
class EachStockChart extends StatelessWidget {
  final String accessToken;
  final String code;

  const EachStockChart({
    super.key,
    required this.accessToken,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      // color: Colors.greenAccent,
      child: const Column(
        children: [
          Text(''),
        ],
      ),
    );
  }
}

// 주요 지수 요약표
class SummaryMajorIndex extends StatelessWidget {
  final String accessToken;
  final String title;
  final String code;
  final double height;

  const SummaryMajorIndex({
    super.key,
    required this.accessToken,
    required this.title,
    required this.code,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StockService().getMajorIndex(accessToken, code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            // color: Colors.grey,
            height: height,
            child: const Center(
              // 로딩 표시
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            // color: Colors.grey,
            height: height,
            child: const Center(
              // 에러 표시
              child: Text("Error loading data"),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return SizedBox(
            // color: Colors.grey,
            height: height,
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('123'),
                        // Text('${data.currentPrice}'),
                        // Text('${data.changePrice}'),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${data.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.blue.shade300,
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          // 양수일 때 + 붙여주기
                          '${data.changeRate > 0 ? '+' : ''}'
                              '${data.changePrice}',
                          style: TextStyle(
                            color: data.changeRate > 0
                                ? Colors.red
                                : data.changeRate < 0
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                        // 가격 56000 -> 56,000 처럼 표시
                        // Text(
                        //   NumberFormat('#,###').format(data.price),
                        // ),
                        Text(
                          '${data.changeRate}%',
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

// 개별 종목 요약표
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
                        Text(
                          '${data.changeRate}%',
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

// 거래량 순위 요약표
class SummaryVolRank extends StatelessWidget {
  final String accessToken;

  const SummaryVolRank({
    super.key,
    required this.accessToken,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StockService().getVolumeRanking(accessToken),
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
          // 5 초과면 5까지
          final itemCount = data.length > 5 ? 5 : data.length;

          return SizedBox(
            height: 700,
            child: ListView.builder(
              // 최대 5개만 렌더링
              itemCount: itemCount,
              // 데이터 가져오기
              itemBuilder: (context, index) {
                final item = data[index];

                return SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${item.rank}'),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item.korName),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                NumberFormat('#,###').format(item.price),
                                style: TextStyle(
                                    // fontSize: 16,
                                    color: item.price > 0
                                        ? Colors.red
                                        : item.price < 0
                                            ? Colors.blue
                                            : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // 양수일 때 + 붙여주기
                                '${item.changePriceRate > 0 ? '+' : ''}'
                                    '${item.changePriceRate}%',
                                style: TextStyle(
                                  color: item.changePriceRate > 0
                                      ? Colors.red
                                      : item.changePriceRate < 0
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
              },
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

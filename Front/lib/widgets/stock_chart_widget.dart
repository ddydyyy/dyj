// widgets/stock_chart_widget.dart

import 'package:finance/services/stock_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'global_widget.dart';

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
    return buildStockData(
      StockService().getMajorIndex(accessToken, code),
      height,
      (context, data) {
        return SizedBox(
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
    return buildStockData(
      StockService().getStockData(accessToken, code),
      60.0,
      (context, data) {
        return SizedBox(
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
              )
            ],
          ),
        );
      },
    );
  }
}

// 거래량 순위 요약표
class SummaryVolRank extends StatelessWidget {
  final String accessToken;
  final int selectedIndex;
  // 한 칸 높이
  final double height;

  const SummaryVolRank({
    super.key,
    required this.accessToken,
    required this.selectedIndex,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return buildStockData(
      StockService().getVolumeRanking(accessToken),
      // 로딩중, 에러 등 높이
      height * 5,
      (context, data) {
        final itemCount = data.length > 5 ? 5 : data.length;
        return SizedBox(
          height: height * 5,
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final item = data[index];
              return SizedBox(
                height: height,
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
                                  color: item.changePriceRate > 0
                                      ? Colors.red
                                      : item.changePriceRate < 0
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
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

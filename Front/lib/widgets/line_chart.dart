import 'package:fl_chart/fl_chart.dart'; // fl_chart 패키지 사용
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider 사용
import '../provider/stock_chart_provider.dart'; // StockChartProvider import
import '../models/stock_chart_model.dart';  // 모델

class LineChartWidget extends StatefulWidget {
  final String symbol;
  const LineChartWidget({Key? key, required this.symbol}) : super(key: key);

  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  late StockChartProvider _stockChartProvider;

  @override
  void initState() {
    super.initState();
    // 데이터를 처음 로딩할 때 호출
    Future.microtask(() {
      _stockChartProvider = Provider.of<StockChartProvider>(context, listen: false);
      _stockChartProvider.fetchStockChartChart(widget.symbol);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StockChartProvider>(
      builder: (context, provider, child) {
        // 데이터가 로딩 중이면 로딩 인디케이터 표시
        if (provider.stockChartList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        // 데이터를 FlSpot 형태로 변환
        List<FlSpot> _lineChartData = provider.stockChartList
            .map((e) => FlSpot(e.time.millisecondsSinceEpoch.toDouble(), e.close))
            .toList();

        return LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: _lineChartData,
                isCurved: true, // 선을 부드럽게 그리기
                color: Colors.blue, // 선 색상
                belowBarData: BarAreaData( // 아래 배경 설정
                    show: true,
                    color: Colors.blue.withOpacity(0.3) // 배경 색상
                ),
              ),
            ],
            titlesData: FlTitlesData(show: true),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
          ),
        );
      },
    );
  }
}
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
  @override
  void initState() {
    super.initState();
    Provider.of<StockChartProvider>(context, listen: false)
        // .load5MinData();
        .load5MinData(widget.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('test'),
    );
    // return Consumer<StockChartProvider>(
    //   builder: (context, provider, child) {
    //     if (provider.data.isEmpty) {
    //       return Center(child: CircularProgressIndicator());
    //     }

        // return LineChart(LineChartData(
        //   lineBarsData: [
        //     LineChartBarData(
        //       spots: provider.data
        //           .map((e) => FlSpot(
        //         e.timestamp.millisecondsSinceEpoch.toDouble(),
        //         e.close,
        //       ))
        //           .toList(),
        //       isCurved: true,
        //       color: Colors.blue,
        //       barWidth: 2,
        //     ),
        //   ],
        // ));
    //   },
    // );
  }
}
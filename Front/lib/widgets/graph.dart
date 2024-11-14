import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphWidget extends StatelessWidget {
  final data;
  const GraphWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // 마지막 점에만 텍스트 표시
    List<Widget> textWidgets = [
      if (data.isNotEmpty) // spots가 비어있지 않으면
        Positioned(
          left: data.last.x * 50,  // x 위치 조정 (비율에 맞게)
          bottom: data.last.y * 10, // y 위치 조정 (비율에 맞게)
          child: Text(
            '${data.last}',  // 마지막 가격 표시
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          // 배경 격자
          gridData: FlGridData(show: false),
          // 경계선
          borderData: FlBorderData(show: false),
          // 마지막 데이터의 가격만 표시
          lineBarsData: [
            LineChartBarData(
              spots: data,
              // spots: [
              //   FlSpot(0, 1),
              //   FlSpot(1, 2),
              //   FlSpot(2, 1.5),
              //   FlSpot(3, 3),
              //   FlSpot(4, 2),
              //   FlSpot(5, 4),
              // ],
              isCurved: false,
              color: Colors.blue,
              dotData: FlDotData(show: false),
              isStrokeCapRound: true, // 점선 스타일 설정
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              // tooltipBgColor: Colors.black.withOpacity(0.8),
              tooltipRoundedRadius: 8,
              getTooltipItems: (touchedSpots) {
                // 마지막 포인트에만 텍스트 표시
                if (touchedSpots.isNotEmpty) {
                  final lastSpot = touchedSpots.last;
                  if (lastSpot.x == 5) { // 마지막 포인트의 x 좌표 체크
                    return [
                      LineTooltipItem(
                        lastSpot.y.toStringAsFixed(2),
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ];
                  }
                }
                return [];
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                interval: 3,

                // 제목과 차트 사이 공간
                reservedSize: 50,
              ),
              // axisNameWidget: Text('Y Axis'),

            ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    // X축 값에 대한 시간 포맷 적용
                    String time = formatTime(value.toInt());
                    return Text(time, style: TextStyle(fontSize: 10)); // '10:00' 형식으로 리턴
                  },
                ),
              ),
            rightTitles: AxisTitles(
              // axisNameWidget: Text('Right Axis'),
              sideTitles: SideTitles(showTitles: false),   // 오른쪽 Y축 라벨 표시 안 함
            ),
            topTitles: AxisTitles(
              // axisNameWidget: Text('Top Axis'),
              sideTitles: SideTitles(showTitles: false),     // 위 X축 라벨 표시 안 함
            ),
          ),
        ),
      ),
    );
  }
}

String formatTime(int time) {
  // '100000'을 DateTime으로 변환하기 위해 문자열로 처리 후 DateFormat 사용
  String timeString = time.toString().padLeft(6, '0'); // 100000 -> '100000'
  DateTime dateTime = DateTime.parse('2024-01-01 $timeString');
  return DateFormat('HH:mm').format(dateTime); // '10:00' 형식으로 변환
}
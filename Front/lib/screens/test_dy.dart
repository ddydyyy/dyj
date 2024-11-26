import 'package:finance/provider/stock_provider.dart';
import 'package:finance/services/stock_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestDY extends StatelessWidget {
  const TestDY({super.key});

  @override
  Widget build(BuildContext context) {
    // 토큰발급
    final accessToken = Provider.of<StockProvider>(context).accessToken;

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: TextButton(
            // accessToken 확인
            // onPressed: () => print(stockProvider.accessToken),
            onPressed: () => {
              // StockService().getMinData(accessToken),
              // print(''),
              // StockService().getMajorIndex(accessToken, '0001'),
              StockService().getMarketCapRanking(accessToken),
            },

            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.greenAccent,
            ),
            child: const Text('Test 버튼'),
          ),
        ),
      ],
    );
  }
}

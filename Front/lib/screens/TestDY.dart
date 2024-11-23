import 'package:finance/provider/StockProvider.dart';
import 'package:finance/services/StockService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestDY extends StatelessWidget {
  const TestDY({super.key});

  @override
  Widget build(BuildContext context) {
    // 토큰발급
    final accessToken = Provider.of<StockProvider>(context).accessToken;

    return Container(
      child: Column(
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
                StockService().getMajorIndex(accessToken, '0001'),
              },

              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.greenAccent,
              ),
              child: const Text('Test 버튼'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:finance/provider/provider.dart';
import 'package:finance/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockSummary extends StatelessWidget {
  const StockSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StockBox(),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class StockBox extends StatelessWidget {
  // final int index;
  // final int selectedIndex;
  // final Function(int) onSelected;

  const StockBox({
    super.key,
    // required this.index,
    // required this.selectedIndex,
    // required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 130,
      width: 170,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode
            ? AppTheme.darkTheme.primaryColor
            : AppTheme.lightTheme.primaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '코스피',
          ),
          SizedBox(height: 8),
          Text(
            '2,671.57',
            style: themeProvider.isDarkMode
                ? AppTheme.darkTheme.bodyLargeStyle
                : AppTheme.lightTheme.bodyLargeStyle,
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                '+2.90%',
                style: TextStyle(
                  fontSize: themeProvider.isDarkMode
                      ? AppTheme.darkTheme.bodySmallStyle.fontSize
                      : AppTheme.lightTheme.bodySmallStyle.fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '75.25',
                style: TextStyle(
                  fontSize: themeProvider.isDarkMode
                      ? AppTheme.darkTheme.bodySmallStyle.fontSize
                      : AppTheme.lightTheme.bodySmallStyle.fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

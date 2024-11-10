import 'package:finance/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme.dart';

class GraphRow extends StatefulWidget {
  const GraphRow({super.key});

  @override
  _GraphRowState createState() => _GraphRowState();
}

class _GraphRowState extends State<GraphRow> {
  // 선택된 항목 인덱스
  int _selectedIndex = 0;

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Graph(
          title: "국내주식",
          index: 0,
          selectedIndex: _selectedIndex,
          onSelected: _onSelected,
        ),
        Graph(
          title: "해외주식",
          index: 1,
          selectedIndex: _selectedIndex,
          onSelected: _onSelected,
        ),
        Graph(
          title: "ETFs",
          index: 2,
          selectedIndex: _selectedIndex,
          onSelected: _onSelected,
        ),
      ],
    );
  }
}





class Graph extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onSelected;

  const Graph({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // provider.dart에 저장된 현재 테마 가져옴
    final themeProvider = Provider.of<ThemeProvider>(context);

    return TextButton(
      onPressed: () {
        print('graph.widget_76_$index');
        onSelected(index);
      },
      child: Text(
        title,
        style: TextStyle(
          color: selectedIndex == index
              ? Colors.orange // 선택된 항목은 주황색
              : (themeProvider.isDarkMode ? Colors.white : Colors.black),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

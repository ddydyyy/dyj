import 'package:flutter/material.dart';

Widget buildStockData(
    Future<dynamic> future,
    double height,
    Widget Function(BuildContext, dynamic) onData,
    ) {
  return FutureBuilder(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasError) {
        return SizedBox(
          height: height,
          child: const Center(child: Text("Error loading data")),
        );
      } else if (snapshot.hasData) {
        return onData(context, snapshot.data);
      } else {
        return SizedBox(
          height: height,
          child: const Center(child: Text("No data available")),
        );
      }
    },
  );
}
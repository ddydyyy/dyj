import 'package:flutter/material.dart';

class dy_temp extends StatelessWidget {
  const dy_temp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(32.0),
      child: const Text(
        'dy',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

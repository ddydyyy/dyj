// import 'package:finance/provider/theme_provider.dart';
// import 'package:finance/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class StockSummary extends StatelessWidget {
//   const StockSummary({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             StockBox(),
//           ],
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }
// }
//
// class StockBox extends StatelessWidget {
//   // final int index;
//   // final int selectedIndex;
//   // final Function(int) onSelected;
//
//   const StockBox({
//     super.key,
//     // required this.index,
//     // required this.selectedIndex,
//     // required this.onSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     // final a=MediaQuery.of(context).size.width * 0.9;
//     // final b = 0.5*a;
//     // print('a : $a, b : $b');
//     return Container(
//
//       // width: ,
//       height: 50,
// //
//       // padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: themeProvider.isDarkMode
//             ? AppTheme.darkTheme.primaryColor
//             : AppTheme.lightTheme.primaryColor,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: Colors.grey,
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '코스피  2,671.57',
//             style: TextStyle(
//               fontSize: 12
//             ),
//           ),
//           SizedBox(height: 8),//
//           Text(
//             '123',
//             // '2,671.57',
//             style: TextStyle(
//               color: themeProvider.isDarkMode
//                   ? AppTheme.darkTheme.bodyLargeStyle.color
//                   : AppTheme.lightTheme.bodyLargeStyle.color,
//               fontSize: 10,
//             )
//           ),
//           SizedBox(height: 4),
//           Row(
//             children: [
//               Text(
//                 '+2.90%',
//                 style: TextStyle(
//                   fontSize: themeProvider.isDarkMode
//                       ? AppTheme.darkTheme.bodySmallStyle.fontSize
//                       : AppTheme.lightTheme.bodySmallStyle.fontSize,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.redAccent,
//                 ),
//               ),
//               SizedBox(width: 4),
//               // Text(
//               //   '75.25',
//               //   style: TextStyle(
//               //     fontSize: themeProvider.isDarkMode
//               //         ? AppTheme.darkTheme.bodySmallStyle.fontSize
//               //         : AppTheme.lightTheme.bodySmallStyle.fontSize,
//               //     fontWeight: FontWeight.w600,
//               //     color: Colors.redAccent,
//               //   ),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

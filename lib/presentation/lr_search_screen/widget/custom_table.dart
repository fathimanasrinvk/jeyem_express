import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({required this.data});

  final List<Map<String, String>> data;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: ColorTheme.maincolor),
      children: data.map((item) {
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['label']!, style: TextStyle(fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['value']!, style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      }).toList(),
    );
  }
}

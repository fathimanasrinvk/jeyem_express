import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class CustomTable extends StatelessWidget {
  final List<TableRow> rows;

  const CustomTable({
    Key? key,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: ColorTheme.maincolor),
      children: rows,
    );
  }
}

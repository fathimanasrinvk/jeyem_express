import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';

class TrackOrderDetailsCard extends StatelessWidget {
  final String label;
  final String value;

  const TrackOrderDetailsCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GLTextStyles.poppins2(),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8.0),
        Text(
          value,
          style: GLTextStyles.poppins2(),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8.0),
        Divider(
          color: ColorTheme.white,
          thickness: 1.0,
        ),
      ],
    );
  }
}

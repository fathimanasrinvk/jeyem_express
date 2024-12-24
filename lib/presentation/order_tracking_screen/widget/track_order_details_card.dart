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
    var size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GLTextStyles.poppins(size: 16),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          value,
          style: GLTextStyles.poppins1(),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: size.height * 0.015),
        Divider(
          color: ColorTheme.maincolor,
          thickness: 1.0,
        ),
      ],
    );
  }
}
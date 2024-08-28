import 'package:flutter/material.dart';

import '../../../core/constants/text_styles.dart';

class BookingStatusRow extends StatelessWidget {
  const BookingStatusRow({required this.size, required this.status});

  final Size size;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Booking Status :',
            style: GLTextStyles.poppins(),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: size.height * 0.01),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                status,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

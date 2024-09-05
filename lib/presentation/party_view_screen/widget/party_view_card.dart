import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../repository/api/common/model/details_model.dart';
import '../../../repository/api/party_view_screen/model/party_view_model.dart';

class BookingDetails extends StatelessWidget {
  final Size size;
  final List<Datum> bookingDetails;

  const BookingDetails({
    Key? key,
    required this.size,
    required this.bookingDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: size.height * 0.03),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'SI',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Booking Date',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'LR No',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Inv. No',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Consignee',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'To',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Boxes',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Pay Type',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: GLTextStyles.poppins(),
                  ),
                ),
              ],
              rows: bookingDetails.asMap().entries.map((entry) {
                int index = entry.key; // Row index
                Datum booking = entry.value; // Booking details
                return DataRow(cells: [
                  DataCell(Text((index + 1).toString())), // SI number column
                  DataCell(Text(booking.bookingDate??'')),
                  DataCell(Text(booking.lrNumber ?? '')),
                  DataCell(Text(booking.invoiceNo ?? '')),
                  DataCell(Text(booking.consigneeName ?? '')),
                  DataCell(Text(booking.endStationName ?? '')),
                  DataCell(Text(booking.noBoxes?.toString() ?? '')),
                  DataCell(Text(booking.paymentType??''),),
                  DataCell(Text(booking.bookingStatus??'')),
                  // DataCell(Text(  booking.bookingStatus?.toString() ?? 'N/A'),)
                ]);
              }).toList(),
              border: TableBorder(
                horizontalInside:
                BorderSide(color: ColorTheme.maincolor, width: 0.5),
                verticalInside:
                BorderSide(color: ColorTheme.maincolor, width: 0.5),
                bottom: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                top: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                left: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                right: BorderSide(color: ColorTheme.maincolor, width: 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

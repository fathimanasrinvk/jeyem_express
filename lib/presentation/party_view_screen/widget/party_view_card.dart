import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../repository/api/party_view_sceen/model/party_view_model.dart';

class BookingDetails extends StatelessWidget {
  final Size size;
  final List<Datum> bookingDetails;

  const   BookingDetails({
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
                    'LR No',
                    style: GLTextStyles.poppins(),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
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

              ],
              rows: bookingDetails.asMap().entries.map((entry) {
                int index = entry.key; // Row index
                Datum booking = entry.value; // Booking details
                return DataRow(cells: [
                  DataCell(Text((index + 1).toString(),style: GLTextStyles.textformfieldhint(size: 15))), // SI number column
                  DataCell(Text(booking.lrNumber ?? '',style: GLTextStyles.textformfieldhint(size: 15),)),
                  DataCell(Text(booking.bookingStatus??'',
                    style: GLTextStyles.textformfieldhint(
                      size: 15,
                      color: booking.bookingStatus == 'DELIVERED' ? Colors.green : Colors.black,
                    ),
                  )),
                  DataCell(Text(booking.invoiceNo ?? '',style: GLTextStyles.textformfieldhint(size: 15),)),
                  DataCell(Text(booking.consigneeName ?? '',style: GLTextStyles.textformfieldhint(size: 15),)),
                  DataCell(Text(booking.endStationName ?? '',style: GLTextStyles.textformfieldhint(size: 15),)),
                  DataCell(Text(booking.noBoxes?.toString() ?? '',style: GLTextStyles.textformfieldhint(size: 15),)),
                  DataCell(Container(
                      color:ColorTheme.lightcolor,
                      child: Text(booking.paymentType??'',style: GLTextStyles.textformfieldhint(size: 15),)),),
                  // DataCell(Text(  booking.bookingStatus?.toString() ?? 'N/A'),)
                ]);
              }).toList(),
              border: TableBorder(
                horizontalInside:
                BorderSide(color: ColorTheme.maincolor, width: 1.0),
                verticalInside:
                BorderSide(color: ColorTheme.maincolor, width: 1.0),
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
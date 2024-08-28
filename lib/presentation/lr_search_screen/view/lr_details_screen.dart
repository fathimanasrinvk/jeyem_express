import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';
import '../widget/booking_status_row.dart';
import '../widget/custom_table.dart';
import '../widget/party_detail_card.dart';

class LRDetailsScreen extends StatelessWidget {
  final List<Map<String, String>> lrDetails = [
    {'label': 'LR CHARGE :', 'value': '20 /-'},
    {'label': 'FREIGHT :', 'value': '300 /-'},
    {'label': 'EXTRA FREIGHT :', 'value': '0 /-'},
    {'label': 'TOTAL :', 'value': '320 /-'},
    {'label': 'GST Amount :', 'value': '0 /-'},
    {'label': 'BILL DISCOUNT :', 'value': '0 /-'},
    {'label': 'NET TOTAL :', 'value': '320 /-'},
    {'label': 'BALANCE :', 'value': '320 /-'},
  ];

  final List<Map<String, String>> bookingDetails = [
    {'label': 'Booked On :', 'value': '20-08-2024'},
    {'label': 'Booked At:', 'value': 'TRIVANDRUM'},
    {'label': 'Payment Mode:', 'value': 'ACCOUNT'},
    {'label': 'Invoice No:', 'value': '556'},
    {'label': 'Gst Invoice No:', 'value': 'JEL475937'},
    {'label': 'Booked By:', 'value': 'MUHAMMED FARIS T'},
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(left: size.width * .1, right: size.width * .1),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LR NUMBER  : JEL1701234TVM',
                style: GLTextStyles.poppins(),
              ),
              SizedBox(height: size.height * .01),
              BookingStatusRow(size: size, status: 'DELIVERED'),
              SizedBox(height: size.height * .03),
              CustomTable(data: lrDetails),
              SizedBox(height: size.height * 0.012),
              CustomButton(size: size, label: 'POD', onPressed: () {}),
              SizedBox(height: size.height * .02),
              Text('Booking Details :', style: GLTextStyles.poppins()),
              SizedBox(height: size.height * .02),
              CustomTable(data: bookingDetails),
              SizedBox(height: size.height * 0.03),
              PartyDetailsCard(
                size: size,
                title: 'Consignor Party',
                details: [
                  'AADITHYA MULTI TRADE LINKS',
                  'Station:TRIVANDRUM',
                  'GST: 32AMYPS0507N1ZI',
                  'AADR: TENRA 77 ELANGHAM NAGAR THYCAUD',
                  'PH: 0',
                  'Email :',
                ],
              ),
              SizedBox(height: size.height * 0.03),
              PartyDetailsCard(
                size: size,
                title: 'Consignee Party',
                details: [
                  'GRACE MEDICALS',
                  'Station:THRISSUR',
                  'GST: 32AACFG1092J1ZO',
                  'AADR:  X/725/7,8, GROUND-FIRST FLOOR, PALLIKULAM ROAD, PALLIKULAM ROAD, ERINJERY ANGADY THRISSUR',
                  'PH: 0',
                  'Email :',
                ],
              ),
              Divider(height: size.height * 0.04),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.size, required this.label, required this.onPressed});

  final Size size;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: Colors.blue,
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}

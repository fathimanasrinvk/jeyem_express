import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:jeyem_express_cargo/presentation/lr_search_screen/widget/party_detail_card.dart';
import 'package:jeyem_express_cargo/presentation/party_view_screen/controller/partY_view_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../widget/party_view_card.dart';

class PartyViewScreen extends StatefulWidget {
  final String digits;

  PartyViewScreen({required this.digits});

  @override
  _PartyViewScreenState createState() => _PartyViewScreenState();
}

class _PartyViewScreenState extends State<PartyViewScreen> {
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    fetchDetailData();
    super.initState();
  }

  Future<void> fetchDetailData() async {
    if (fromDate != null && toDate != null) {
      await Provider.of<PartyViewController>(context, listen: false)
          .fetchDetailData(widget.digits, fromDate!, toDate!, context);
    } else {
      // Handle case when dates are not selected
      AppUtils.oneTimeSnackBar("Please select both dates", context: context, bgColor: ColorTheme.red);
    }
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate ?? DateTime.now() : toDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.white,
      ),
      body: Padding(
      padding: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("From Date", style: TextStyle(color: Colors.black)),
                  SizedBox(height: size.height * 0.002),
                  GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.011, horizontal: size.width * 0.03),
                      decoration: BoxDecoration(
                        color: ColorTheme.lightcolor,
                        border: Border.all(color: ColorTheme.maincolor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        fromDate != null
                            ? DateFormat.yMMMMd().format(fromDate!)
                            : 'Select Date',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: size.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("To Date", style: TextStyle(color: Colors.black)),
                  SizedBox(height: size.height * 0.002),
                  GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.011, horizontal: size.width * 0.03),
                      decoration: BoxDecoration(
                        color: ColorTheme.lightcolor,
                        border: Border.all(color: ColorTheme.maincolor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        toDate != null
                            ? DateFormat.yMMMMd().format(toDate!)
                            : 'Select Date',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 26),
          GestureDetector(
            onTap: () {
              fetchDetailData();
            },
            child: Padding(
              padding: EdgeInsets.only(left: size.width * 0.2, right: size.width * 0.2),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorTheme.maincolor,
                  borderRadius: BorderRadius.circular(7),
                ),
                height: size.height * 0.052,
                child: Center(
                  child: Text('Search', style: TextStyle(color: ColorTheme.white)),
                ),
              ),
            ),
          ),
          Consumer<PartyViewController>(
            builder: (context, controller, _) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.grey,
                  ),
                );
              }
              else if (controller.partyViewModel.data == null) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No details available',
                      style: GLTextStyles.mainTittle(),
                    ),
                  ),
                );
              }
              else {
                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorTheme.maincolor)
                      ),
                      width: 370,
                      child: BookingDetails(
                        size: size,
                        bookingDetails: controller.partyViewModel.data ?? [],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 30,)
        ],
      ),
              ),
      backgroundColor: ColorTheme.white,
    );
  }
}


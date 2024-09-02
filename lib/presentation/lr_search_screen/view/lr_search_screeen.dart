import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../login_screeen/view/login_screen.dart';
import '../../order_tracking_screen/controller/details_controller.dart';
import '../widget/booking_status_row.dart';
import '../widget/custom_table.dart';
import '../widget/party_detail_card.dart';
import '../widget/prdct_vehicle_details_table.dart';

class LrSearchScreen extends StatefulWidget {
  final trackNumber;

  const LrSearchScreen({super.key, this.trackNumber});

  @override
  _LrSearchScreenState createState() => _LrSearchScreenState();
}

class _LrSearchScreenState extends State<LrSearchScreen> {
  final TextEditingController trackNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.trackNumber != null) {
      trackNumberController.text = widget.trackNumber.toString();
      fetchData();
    }
  }

  @override
  void dispose() {
    trackNumberController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    await Provider.of<DetailsController>(context, listen: false)
        .fetchDetailData(trackNumberController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Lottie.asset("assets/animation/wired-lineal-497-truck-delivery.json",width: size.width*0.15,height: size.height*0.062
              )
            ),
            Expanded(
                child: Center(
                    child: Text(
              'LR SEARCH',
              style: TextStyle(color: ColorTheme.black),
            ))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),

              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcdsC6_g4tHOfg6UsEMCzvW4cqwK6nXUCljg&s'),
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.logout_outlined,
                  size: size.height * 0.04,
                  color: ColorTheme.maincolor,
                ),
                onPressed: showLogoutConfirmation,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * .03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .08),
            child: TextFormField(
              controller: trackNumberController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      final trackNumber = trackNumberController.text;
                      if (trackNumber.isNotEmpty) {
                        fetchData();
                      }
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: ColorTheme.secondarycolor,
                  ),
                ),
                filled: false,
                hintText: 'LR Search',
                hintStyle: TextStyle(color: ColorTheme.secondarycolor),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: size.width * .05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                      width: size.width * .02, color: ColorTheme.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                      color: ColorTheme.black, width: size.width * .004),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide:
                      BorderSide(color: ColorTheme.secondarycolor, width: size.width * .004),
                ),
              ),
            ),
          ),
          Consumer<DetailsController>(
            builder: (context, controller, _) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.grey,
                  ),
                );
              } else if (controller.detailsModel.booking == null) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No details available',
                      style: GLTextStyles.mainTittle(),
                    ),
                  ),
                );
              } else {
                return Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * .03),

                          Center(
                            child: Text(
                              'LR NUMBER  : ${controller.detailsModel.booking?.lrNumber}',
                              style: GLTextStyles.poppins(),
                            ),
                          ),
                          SizedBox(height: size.height * .02),
                          BookingStatusRow(
                              size: size,
                              status:
                                  "${controller.detailsModel.booking?.dsrDelivery}"),
                          SizedBox(height: size.height * .03),

                          // Custom Table with LR Details
                          CustomTable(
                            rows: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('LR CHARGE :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.lrCharge}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('FREIGHT :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.freight}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('EXTRA FREIGHT :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.extraCharge}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('TOTAL :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.total}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('GST Amount :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.gstAmount}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('BILL DISCOUNT :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.billDiscount}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('NET TOTAL :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.netTotal}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('BALANCE :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.netTotal}/-',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.012),
                          CustomButton(
                              size: size, label: 'POD', onPressed: () {}),
                          SizedBox(height: size.height * .02),

                          Text('Booking Details :',
                              style: GLTextStyles.poppins()),
                          SizedBox(height: size.height * .02),

                          // Custom Table with Booking Details
                          CustomTable(
                            rows: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('Booked On :',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.bookedOn}',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('Booked At:',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.bookedAt}',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('Payment Mode:',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ,right: size.width*0.02),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: ColorTheme.maincolor,
                                        ),
                                        child: Center(
                                            child: Text(
                                                '${controller.detailsModel.booking?.paymentMode}',
                                                style:
                                                    TextStyle(fontSize: 16)))),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('Invoice No:',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.invoiceNo}',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('Gst Invoice No:',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.gstInvoice}',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text('Booked By:',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width*0.02,top:size.height*0.01 ,bottom:size.height*0.01 ),
                                    child: Text(
                                        '${controller.detailsModel.booking?.bookedBy}',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.03),

                          PartyDetailsCard(
                            size: size,
                            title: 'Consignor Party',
                            details: [
                              '${controller.detailsModel.consignorParty?.partyName}',
                              'Station:${controller.detailsModel.consignorParty?.station}',
                              'GST: ${controller.detailsModel.consignorParty?.gst}',
                              'AADR: ${controller.detailsModel.consignorParty?.address}',
                              'PH: ${controller.detailsModel.consignorParty?.phone}',
                              'Email :${controller.detailsModel.consignorParty?.email}',
                            ],
                          ),

                          SizedBox(height: size.height * 0.03),

                          PartyDetailsCard(
                            size: size,
                            title: 'Consignee Party',
                            details: [
                              '${controller.detailsModel.consigneeParty?.partyName}',
                              'Station:${controller.detailsModel.consigneeParty?.station}',
                              'GST: ${controller.detailsModel.consigneeParty?.gst}',
                              'AADR: ${controller.detailsModel.consigneeParty?.address}',
                              'PH:${controller.detailsModel.consigneeParty?.phone}',
                              'Email :${controller.detailsModel.consigneeParty?.email}',
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          ProductAndVehicleDetails(
                            size: size,
                            productDetails: [
                              {
                                'item':
                                    '${controller.detailsModel.itemDetails?.item}',
                                'size':
                                    '${controller.detailsModel.itemDetails?.size}',
                                'quantity':
                                    '${controller.detailsModel.itemDetails?.quantity}',
                                'freight':
                                    '${controller.detailsModel.itemDetails?.freight}',
                              }
                            ],
                            vehicleDetails:
                                controller.detailsModel.dispatchDetails ?? [],
                          ),
                          Divider(height: size.height * 0.04),
                        ],
                      ),
                    ],
                  ),
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppConfig.token);
    await sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  void showLogoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Logout',
            style: GLTextStyles.cabinStyle(size: 18),
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.size,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

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

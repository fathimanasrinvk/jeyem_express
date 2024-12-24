import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../../order_tracking_screen/controller/details_controller.dart';
import '../../selection_screen/view/selection_screen.dart';
import '../widgets/booking_status_row.dart';
import '../widgets/custom-table.dart';
import '../widgets/party_detail_card.dart';
import '../widgets/prdct_vehicle_details_table.dart';

class LrSearchScreen extends StatelessWidget {
  final String? trackNumber;

  const LrSearchScreen({super.key, this.trackNumber});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final trackNumberController = TextEditingController(text: trackNumber);

    // Fetch the username when the screen is loaded
    Future.delayed(Duration.zero, () async {
      await Provider.of<DetailsController>(context, listen: false).fetchUsername();
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme.maincolor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: size.width * 0.03),
          child: Lottie.asset(
            "assets/animation/lr_lottie.json",
            width: size.width * 0.17,
            height: size.height * 0.062,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: ColorTheme.maincolor,
        elevation: 0,
        title: Text('LR SEARCH', style: GLTextStyles.mainColorTitle1()),      ),
      endDrawer: Drawer(
        backgroundColor: ColorTheme.maincolor,
        child: Consumer<DetailsController>(
          builder: (context, detailsController, _) {
            final username = detailsController.username; // Now we can access username here
            return Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: ColorTheme.lightcolor
                  ),
                  accountName: Text(username, style: GLTextStyles.username()),
                  accountEmail: Text(''),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcdsC6_g4tHOfg6UsEMCzvW4cqwK6nXUCljg&s'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03, top: size.height * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorTheme.lightcolor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: size.width * 0.05),
                        Expanded(
                          child: Text(
                            'Logout',
                            style: GLTextStyles.poppins(color: ColorTheme.maincolor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.logout_outlined,
                            size: size.height * 0.03,
                            color: ColorTheme.maincolor,
                          ),
                          onPressed: () => _showLogoutConfirmation(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: size.height * .05,
              left: size.width * .06,
              right: size.width * .06,

            ),
            child: Container(
              height: size.height * 0.16,
              decoration: BoxDecoration(
                color: ColorTheme.blue,
                  // image: DecorationImage(image: AssetImage('assets/images/gradient.jpg'), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      // top: size.height * 0.02,
                      left: size.width * 0.04,
                      right: size.width * 0.04,
                      // bottom: size.height * 0.06
                  ),
                  child: TextFormField(
                    style: GLTextStyles.textformfieldhint1(),
                    controller: trackNumberController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus(); // Hides the keyboard

                          if (trackNumberController.text.isEmpty) {
                            AppUtils.showFlushbar(
                                context: context,
                                message:"LR Number Is Required",
                                messageColor: ColorTheme.red,
                                backgroundColor: ColorTheme.lightcolor,
                                icon: Icons.error,
                                borderRadius: BorderRadius.circular(7),
                          widthFactor: 0.52);

                          }

                          else{
                            Provider.of<DetailsController>(context, listen: false)
                                .fetchDetailData(trackNumberController.text, context);
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          color: ColorTheme.maincolor,
                        ),
                      ),
                      filled: true,
                      fillColor: ColorTheme.white,
                      hintText: 'LR Search',
                      hintStyle: GLTextStyles.textformfieldhint1(),
                      contentPadding: EdgeInsets.symmetric(horizontal: size.width * .05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: size.width * .02, color: ColorTheme.maincolor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: ColorTheme.maincolor, width: size.width * .004),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: ColorTheme.black,
                            width: size.width * .004),
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      if (trackNumberController.text.isNotEmpty) {
                        Provider.of<DetailsController>(context, listen: false)
                            .fetchDetailData(trackNumberController.text, context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<DetailsController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.grey,
                    ),
                  );
                } else if (controller.detailsModel.booking == null) {
                  return Center(
                    child: Text(
                      'No details available',
                      style: GLTextStyles.mainColorTitle(),
                    ),
                  );
                } else {
                  return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * .03),

                                Center(
                                    child:RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'LR NUMBER  :   ',
                                              style:GLTextStyles.poppins(size: 16,color: ColorTheme.white)
                                          ),
                                          TextSpan(
                                              text: controller.detailsModel.booking?.lrNumber ?? 'N/A',
                                              style:GLTextStyles.poppins2(size: 18,color: ColorTheme.red)
                                          ),
                                        ],
                                      ),
                                    )

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
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('LR CHARGE ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.lrCharge}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('FREIGHT ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.freight}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('EXTRA FREIGHT ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.extraCharge}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('TOTAL ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.total}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('GST Amount ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.gstAmount}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('BILL DISCOUNT ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.billDiscount}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('NET TOTAL ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.netTotal}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('BALANCE ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.netTotal}/-',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
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
                                    style: GLTextStyles.poppins(color: ColorTheme.white)                                ),
                                SizedBox(height: size.height * .02),

                                // Custom Table with Booking Details
                                CustomTable(
                                  rows: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: ColorTheme.white, // Set background color to white
                                      ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('Booked On ',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.bookedOn}',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(   decoration: BoxDecoration(
                                      color: ColorTheme.white, // Set background color to white
                                    ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('Booked At',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.bookedAt}',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(   decoration: BoxDecoration(
                                      color: ColorTheme.white, // Set background color to white
                                    ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('Payment Mode',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.06,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01,
                                              right: size.width * 0.06),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(7),
                                                color: ColorTheme.lightcolor,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                      '${controller.detailsModel.booking?.paymentMode}',
                                                      style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)))),
                                        ),
                                      ],
                                    ),
                                    TableRow(   decoration: BoxDecoration(
                                      color: ColorTheme.white, // Set background color to white
                                    ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('Invoice No',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.invoiceNo}',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(   decoration: BoxDecoration(
                                      color: ColorTheme.white, // Set background color to white
                                    ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('Gst Invoice No',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.gstInvoice}',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    TableRow(   decoration: BoxDecoration(
                                      color: ColorTheme.white, // Set background color to white
                                    ),
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text('Booked By',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: Text(
                                              '${controller.detailsModel.booking?.bookedBy}',
                                              style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
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
                                    'PH: ${controller.detailsModel.consignorParty?.phone??''}',
                                    'Email :${controller.detailsModel.consignorParty?.email??''}',
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
                                    'PH: ${controller.detailsModel.consigneeParty?.phone ?? ''}',
                                    'Email :${controller.detailsModel.consigneeParty?.email?? ''}',
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
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorTheme.lightcolor,
          title: Text('Confirm Logout',            style: GLTextStyles.cancel(size: 18),
          ),
          content:  Text('Are you sure you want to log out?',style: GLTextStyles.textformfieldhint1(size: 14)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: GLTextStyles.cancel(size: 14)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout(context);
              },
              child: Text('Logout',style: GLTextStyles.cancel(size: 14)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    final detailsController = Provider.of<DetailsController>(context, listen: false);
    detailsController.clearDetails(); // Clear the data before logging out
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppConfig.token);
    await sharedPreferences.setBool(AppConfig.loggedIn, false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
          (route) => false,
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





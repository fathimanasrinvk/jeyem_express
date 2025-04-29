import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../controller/details_controller.dart';
import '../widget/track_order_details_card.dart';

class TrackOrderScreen extends StatelessWidget {
  final trackNumber;

  const TrackOrderScreen({super.key, this.trackNumber});

  Future<void> fetchData(BuildContext context, String trackNumber) async {
    await Provider.of<DetailsController>(context, listen: false)
        .fetchDetailData(trackNumber, context);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController trackNumberController = TextEditingController();
    if (trackNumber != null) {
      trackNumberController.text = trackNumber.toString();
      fetchData(context, trackNumberController.text);
    }

    var size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<DetailsController>(context, listen: false).clearDetails();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectionScreen()));
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorTheme.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          actions: [
            Flexible(
                child: Image.asset('assets/logo/JEYEM LOGO (2).png',
                    height: size.height * 0.07)),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: ColorTheme.white),
            onPressed: () {
              Provider.of<DetailsController>(context, listen: false)
                  .clearDetails();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SelectionScreen()));
            },
          ),
          backgroundColor: ColorTheme.maincolor,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * .03,
                left: size.width * .06,
                right: size.width * .06,
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.width * 0.04,
                    right: size.width * 0.04,
                  ),
                  child: TextFormField(
                    style: GLTextStyles.textformfieldhint1(),
                    controller: trackNumberController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: ColorTheme.white,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: ColorTheme.maincolor,
                        onPressed: () {
                          final trackNumber = trackNumberController.text;
                          FocusScope.of(context)
                              .unfocus(); // Hides the keyboard

                          if (trackNumber.isEmpty) {
                            AppUtils.showFlushbar(
                                context: context,
                                message: "Track Number Is Required",
                                messageColor: ColorTheme.red,
                                backgroundColor: ColorTheme.lightcolor,
                                icon: Icons.error,
                                borderRadius: BorderRadius.circular(7),
                                widthFactor: 0.52);

                          } else {
                            fetchData(context, trackNumber);
                          }
                        },
                      ),

                      // suffixIcon: IconButton(
                      //   icon: Icon(Icons.search),
                      //   color: ColorTheme.maincolor,
                      //   onPressed: () {
                      //     final trackNumber = trackNumberController.text;
                      //     if (trackNumber.isNotEmpty) {
                      //       fetchData(context, trackNumber);
                      //     }
                      //   },
                      // ),
                      filled: true,
                      hintText: 'Track Your Order',
                      hintStyle: GLTextStyles.textformfieldhint1(),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: size.width * .05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: size.width * .02,
                          color: ColorTheme.maincolor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: ColorTheme.maincolor,
                          width: size.width * .004,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: ColorTheme.maincolor,
                          width: 2,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      if (value.isNotEmpty) {
                        fetchData(context, value);
                      }
                    },
                  ),
                ),
              ),
            ),
            Consumer<DetailsController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return Expanded(
                    child: const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.grey,
                      ),
                    ),
                  );
                } else if (controller.detailsModel.booking == null) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        '',
                        style: GLTextStyles.mainTittle(),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * .03),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),
                                color: ColorTheme.white,
                                border: Border.all(color: ColorTheme.maincolor)
                            ),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                  '   ${controller.detailsModel.booking?.lrNumber}  :   ',
                                  style: GLTextStyles.poppins4(size: 18),
                                ),
                                TextSpan(
                                  text:
                                  '${controller.detailsModel.booking?.dsrDelivery}   ',
                                  style: GLTextStyles.poppins3(size: 20),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(height: size.height * .008),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * .02,
                              right: size.width * .02,
                              top: size.height * .02,
                              bottom: size.height * .02,
                            ),
                            child: Container(
                              height: size.height * 0.66,
                              width: size.width * 0.86,
                              padding: EdgeInsets.all(size.width * 0.02),
                              decoration: BoxDecoration(
                                color: ColorTheme.maincolor,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2.5,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TrackOrderDetailsCard(
                                      label: 'Booking Date'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.booking?.bookedOn}",
                                    ),
                                    if (controller
                                        .detailsModel.booking?.dsrDelivery
                                        ?.toLowerCase() ==
                                        'delivered')
                                      TrackOrderDetailsCard(
                                        label: 'Delivery Date'.toUpperCase(),
                                        value:
                                        "${controller.detailsModel.booking?.deliveryDate}",
                                      ),
                                    TrackOrderDetailsCard(
                                      label: 'LR No'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.booking?.lrNumber}",
                                    ),
                                    TrackOrderDetailsCard(
                                      label: 'Invoice No'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.booking?.invoiceNo}",
                                    ),
                                    TrackOrderDetailsCard(
                                      label: 'Consignor'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.consignorParty?.partyName}",
                                    ),
                                    TrackOrderDetailsCard(
                                      label: 'Consignee'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.consigneeParty?.partyName}",
                                    ),
                                    TrackOrderDetailsCard(
                                      label: 'From'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.consignorParty?.station}",
                                    ),
                                    TrackOrderDetailsCard(
                                      label: 'Destination'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.consigneeParty?.station}",
                                    ),
                                    TrackOrderDetailsCard(
                                      label: 'No of items'.toUpperCase(),
                                      value:
                                      "${controller.detailsModel.itemDetails?.quantity}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
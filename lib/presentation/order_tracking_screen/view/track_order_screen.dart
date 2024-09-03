import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../controller/details_controller.dart';
import '../widget/track_order_details_card.dart';

class TrackOrderScreen extends StatefulWidget {
  final trackNumber;

  const TrackOrderScreen({super.key, this.trackNumber});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
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
    Provider.of<DetailsController>(context, listen: false).clearDetails();
    super.dispose();
  }

  Future<void> fetchData() async {
    await Provider.of<DetailsController>(context, listen: false)
        .fetchDetailData(trackNumberController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<DetailsController>(context, listen: false).clearDetails();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectionScreen()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: ColorTheme.black),
          //   onPressed: () {
          //     Provider.of<DetailsController>(context, listen: false).clearDetails();
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SelectionScreen()));
          //   },
          // ),
          backgroundColor: ColorTheme.maincolor,
          title: Text(
            "TRACK YOUR ORDER",
            style: GLTextStyles.mainTittle(),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * .04,
                left: size.width * .1,
                right: size.width * .1,
              ),
              child: TextFormField(
                controller: trackNumberController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      color: ColorTheme.maincolor,
                      border: Border.all(color: ColorTheme.black),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      color: ColorTheme.black,
                      onPressed: () {
                        final trackNumber = trackNumberController.text;
                        if (trackNumber.isNotEmpty) {
                          fetchData();
                        }
                      },
                    ),
                  ),
                  filled: false,
                  hintText: 'Track Your Order',
                  hintStyle: TextStyle(
                    color: ColorTheme.black,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: size.width * .05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      width: size.width * .02,
                      color: ColorTheme.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: ColorTheme.black,
                      width: size.width * .004,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(
                      color: ColorTheme.maincolor,
                      width: 2,
                    ),
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * .035),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '${controller.detailsModel.booking?.lrNumber}  :   ',
                                style: GLTextStyles.poppins1(),
                              ),
                              TextSpan(
                                text:
                                    '${controller.detailsModel.booking?.dsrDelivery} ',
                                style: GLTextStyles.poppins3(),
                              ),
                            ]),
                          ),
                          SizedBox(height: size.height * .01),
                          Padding(
                            padding: EdgeInsets.all(size.width * .05),
                            child: Container(
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
                              child: Column(
                                children: [
                                  TrackOrderDetailsCard(
                                    label: 'Booking Date',
                                    value:
                                        "${controller.detailsModel.booking?.bookedOn}",
                                  ),
                                  if (controller
                                          .detailsModel.booking?.dsrDelivery
                                          ?.toLowerCase() ==
                                      'delivered')
                                    TrackOrderDetailsCard(
                                      label: 'Delivery Date',
                                      value:
                                          "${controller.detailsModel.booking?.deliveryDate}", // Ensure the delivery date is available in your model
                                    ),

                                  TrackOrderDetailsCard(
                                    label: 'LR No',
                                    value:
                                        "${controller.detailsModel.booking?.lrNumber}",
                                  ),
                                  TrackOrderDetailsCard(
                                    label: 'Invoice No',
                                    value:
                                        "${controller.detailsModel.booking?.invoiceNo}",
                                  ),
                                  TrackOrderDetailsCard(
                                    label: 'Consignor',
                                    value:
                                        "${controller.detailsModel.consignorParty?.partyName}",
                                  ),
                                  TrackOrderDetailsCard(
                                    label: 'Consignee',
                                    value:
                                        "${controller.detailsModel.consigneeParty?.partyName}",
                                  ),
                                  TrackOrderDetailsCard(
                                    label: 'From',
                                    value:
                                        "${controller.detailsModel.consignorParty?.station}",
                                  ),
                                  TrackOrderDetailsCard(
                                    label: 'Destination',
                                    value:
                                        "${controller.detailsModel.consigneeParty?.station}",
                                  ),
                                  TrackOrderDetailsCard(
                                    label: 'No of items',
                                    value:
                                        "${controller.detailsModel.itemDetails?.quantity}",
                                  ),
                                  // TrackOrderDetailsCard(
                                  //   label: 'Acknowledgement',
                                  //   value: '',
                                  // ),
                                ],
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

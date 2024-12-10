import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: ColorTheme.white,
      appBar: AppBar(
        // title: Image.asset('assets/logo/JEYEM LOGO (2).png',height: size.height*0.05,),
        actions: [
          Flexible(child: Image.asset('assets/logo/JEYEM LOGO (2).png',height: size.height*0.07,)),
        ],
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios, color: ColorTheme.lightcolor),
        //   onPressed: () {
        //     Provider.of<DetailsController>(context, listen: false).clearDetails();
        //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SelectionScreen()));
        //   },
        // ),
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
            child: Container(
              height: size.height*0.25,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/gradient.jpg'),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:EdgeInsets.only(top: size.height*0.05,left: size.width*0.04,right: size.width*0.04),
                      child: Text('TRACK YOUR ORDER',style: GLTextStyles.mainColorTitle(),)
                        // style: TextStyle(color: ColorTheme.red,fontSize: 28,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.only(
                        top: size.height*0.02,left: size.width*0.04,right: size.width*0.04,bottom: size.height*0.06),
                    child: TextFormField(
                      controller: trackNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: ColorTheme.white,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: ColorTheme.maincolor,
                          onPressed:() {
                            final trackNumber = trackNumberController.text;
                            if (trackNumber.isNotEmpty){
                              fetchData();
                            }
                          },
                        ),
                        filled: true,
                        hintText: 'Track Your Order',
                        hintStyle: TextStyle(
                          color: ColorTheme.maincolor,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: size.width * .05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: size.width * .02,
                            color: ColorTheme.maincolor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: ColorTheme.white,
                            width: size.width * .004,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: ColorTheme.maincolor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
    );
  }
}

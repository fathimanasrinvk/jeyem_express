import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';

class OrderDetailsScreen extends StatelessWidget {
  final List<Map<String, String>> consignmentDetails = [
    {'label': 'Booking Date', 'value': '24-08-2024'},
    {'label': 'LR No', 'value': 'JPL1712348EKMN'},
    {'label': 'Invoice No', 'value': '115480'},
    {
      'label': 'Consignor',
      'value':
          'MACLEODS PHARMACEUTICALS LTD\nC/O ASSOCIATED AGENCIE,\nPOOKKATUPADI ROAD,\nUNICHHIRA, VELLAKKAL BUILDING,\nEDAPPALLY'
    },
    {
      'label': 'Consignee',
      'value': 'KP & KC ENTERPRISES\nSILAH TOWER,\nKAITHAVALAPPA ROAD, TIRUR'
    },
    {'label': 'From', 'value': 'ERNAKULAM'},
    {'label': 'Destination', 'value': 'TIRUR'},
    {'label': 'No of items', 'value': '7'},
    {'label': 'Acknowledgement', 'value': 'Not uploaded'},
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(
            //       top: size.height * .04,
            //       left: size.width * .1,
            //       right: size.width * .1),
            //   child: TextFormField(
            //     keyboardType: TextInputType.text,
            //     decoration: InputDecoration(
            //       suffixIcon: IconButton(
            //         icon: Icon(Icons.search),
            //         color: ColorTheme.black,
            //         onPressed: () {},
            //       ),
            //       filled: false,
            //       hintText: 'Track Your Order',
            //       hintStyle: TextStyle(color: ColorTheme.black),
            //       contentPadding:
            //           EdgeInsets.symmetric(horizontal: size.width * .05),
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(7),
            //           borderSide: BorderSide(
            //               width: size.width * .02, color: ColorTheme.black)),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(7),
            //         borderSide: BorderSide(
            //             color: ColorTheme.black, width: size.width * .004),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(7),
            //         borderSide:
            //             BorderSide(color: ColorTheme.maincolor, width: 2),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: size.height * .035),
            Text('Searched Consignment Status of',
                style: GLTextStyles.poppins()),
            SizedBox(height: size.height * .0003),
            Text('JPL1712348EKMN :  OUT FOR DELIVERY',
                style: GLTextStyles.poppins1()),
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
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: consignmentDetails.length,
                  separatorBuilder: (context, index) => Divider(
                    color: ColorTheme.white,
                    thickness: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          consignmentDetails[index]['label']!,
                          style: GLTextStyles.poppins2(),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Text(
                          consignmentDetails[index]['value']!,
                          style: GLTextStyles.poppins2(),
                          textAlign: TextAlign.left,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       width: size.width * 0.45,
                        //       child: Text(
                        //         consignmentDetails[index]['label']!,
                        //         style: GLTextStyles.poppins2(),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Text(
                        //         consignmentDetails[index]['value']!,
                        //         style: GLTextStyles.poppins2(),
                        //         textAlign: TextAlign.left,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

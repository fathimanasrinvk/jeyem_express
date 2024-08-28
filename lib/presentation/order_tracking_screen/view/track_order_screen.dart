import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import 'order_details_screen.dart';

class TrackOrderScreen extends StatefulWidget {
  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  bool _showorderdetails = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorTheme.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SelectionScreen()));
            },
          ),
          backgroundColor: ColorTheme.maincolor,
          title: Text(
            "TRACK YOUR ORDER",
            style: GLTextStyles.mainTittle(),
          ),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(
                top: size.height * .03,
                left: size.width * .1,
                right: size.width * .1),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: Container(
                  decoration: BoxDecoration(
                      color: ColorTheme.maincolor,
                      border: Border.all(color: ColorTheme.black)),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    color: ColorTheme.black,
                    onPressed: () {
                      setState(() {
                        _showorderdetails = true;
                      });
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
                        width: size.width * .02, color: ColorTheme.black)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                      color: ColorTheme.black, width: size.width * .004),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: ColorTheme.maincolor, width: 2),
                ),
              ),
            ),
          ),
          if (_showorderdetails) ...[
            SizedBox(height: size.height * .03),
            Expanded(
              child: (OrderDetailsScreen()),
            ),
          ]
        ]));
  }
}

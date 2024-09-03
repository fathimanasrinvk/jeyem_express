import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/presentation/login_screeen/view/login_screen.dart';
import '../../../core/constants/colors.dart';
import '../../order_tracking_screen/view/track_order_screen.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorTheme.white,

      // backgroundColor: ColorTheme.secondarycolor.withOpacity(0.8),
      // backgroundColor: ColorTheme.black.withOpacity(0.8),
      //   body:Container(
      // height: double.infinity,
      // width: double.infinity,
      // decoration: BoxDecoration(
      // gradient: LinearGradient(
      // colors: [
      // Color(0XFF00DDA8),
      // Color(0xFF9C69E3),
      // Color(0xFF9C69E3),
      // Color(0xFF9C69E3)
      // ],
      // begin: Alignment.topLeft,
      // end: Alignment.bottomRight,
      // ),
      // ),
      //   child:
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: size.height*0.1,),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.17, right: size.width * 0.17),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => TrackOrderScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorTheme.maincolor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  width: double.infinity,
                  height: size.height * 0.052,
                  child: Center(
                    child: Text('TRACK ORDER',
                        style: TextStyle(color: ColorTheme.white)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.024,
                  left: size.width * 0.17,
                  right: size.width * 0.17),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorTheme.maincolor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  width: double.infinity,
                  height: size.height * 0.052,
                  child: Center(
                    child: Text('LOGIN',
                        style: TextStyle(color: ColorTheme.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

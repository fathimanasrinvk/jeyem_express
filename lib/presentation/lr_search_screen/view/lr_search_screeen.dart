import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';
import '../../../core/constants/colors.dart';
import 'lr_details_screen.dart';

class LrSearchScreen extends StatefulWidget {
  @override
  _LrSearchScreenState createState() => _LrSearchScreenState();
}

class _LrSearchScreenState extends State<LrSearchScreen> {
  bool _showLRDetails = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Icon(Icons.local_shipping,
                  color: Colors.purple, size: size.height * .04),
            ),
            Expanded(child: Center(child: Text('LR Search'))),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.05, right: size.width * 0.05),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcdsC6_g4tHOfg6UsEMCzvW4cqwK6nXUCljg&s'),

              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * .03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .08),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showLRDetails = true;
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
                      BorderSide(color: ColorTheme.secondarycolor, width: 2),
                ),
              ),
            ),
          ),
          if (_showLRDetails) ...[
            SizedBox(height: size.height * .03),
            Expanded(
              child: LRDetailsScreen(),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';

import '../../../core/constants/text_styles.dart';
class PartyDetailsCard extends StatelessWidget {
  const PartyDetailsCard(
      {required this.size, required this.title, required this.details});

  final Size size;
  final String title;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: ColorTheme.maincolor),
      ),
      width: size.width * 0.9,
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: size.height * 0.025),
                SizedBox(width: size.width * 0.05),
                Expanded(
                  child: Text(title, overflow: TextOverflow.ellipsis,  style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.bold)),
                ),
              ],
            ),
            Divider(color: ColorTheme.maincolor,),
            ...details.map((detail) => Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: Text(
                detail,
                  style:GLTextStyles.textformfieldhint(size: 15,weight: FontWeight.normal)
              ),
            )),
          ],
        ),
      ),
    );
  }
}
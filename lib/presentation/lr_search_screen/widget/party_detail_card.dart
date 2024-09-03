import 'package:flutter/material.dart';
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
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey),
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
                  child: Text(title, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Divider(),
            ...details.map((detail) => Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: Text(
                    detail,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

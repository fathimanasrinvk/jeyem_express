import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../controller/booking_count_screen_controller.dart';

class BookingCountScreen extends StatelessWidget {
  final String digits;

  const BookingCountScreen({Key? key, required this.digits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingCountProvider>(context);
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Booking Count', style: GLTextStyles.poppins2()),
        backgroundColor: ColorTheme.maincolor,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorTheme.maincolor),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: ColorTheme.maincolor),
                    SizedBox(width: size.width * 0.03),
                    Text(
                      controller.selectedDate != null
                          ? DateFormat.yMMMMd().format(controller.selectedDate!)
                          : 'Select Date',
                      style: GLTextStyles.poppins(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              controller: controller.bookingCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Bookings',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.maincolor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.maincolor),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              controller: controller.boxCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Boxes',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.maincolor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.maincolor),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.maincolor,
                minimumSize: Size(double.infinity, size.height * 0.06),
              ),
              onPressed: () => controller.submitCounts(digits, context),
              child: Text('Submit', style: GLTextStyles.poppins2()),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      Provider.of<BookingCountProvider>(context, listen: false)
          .setSelectedDate(picked);
    }
  }
}
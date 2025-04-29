import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../controller/add_booking_count_screen_controller.dart';

class BookingCountScreen extends StatelessWidget {
  final String digits;

  const BookingCountScreen({Key? key, required this.digits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BookingCountProvider>(context);
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios, color: ColorTheme.white),
        ),
        title: Text('SUBMIT BOOKING ', style: GLTextStyles.mainColorTitle1(size: 18)),
        centerTitle: true,
        backgroundColor: ColorTheme.maincolor,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please enter booking details',
                  style: GLTextStyles.poppins().copyWith(
                    fontSize: size.width * 0.04, // 16 equivalent
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                // Date Selection
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.017,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorTheme.maincolor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(size.width * 0.025),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_today,
                            color: ColorTheme.maincolor,
                            size: size.width * 0.05,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.08,
                              right: size.width * 0.06
                          ),
                          child: Text(
                            controller.selectedDate != null
                                ? DateFormat.yMMMMd().format(controller.selectedDate!)
                                : 'Select Date',
                            style: GLTextStyles.poppins(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: ColorTheme.maincolor,
                            size: size.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // Booking Count TextField
                Text(
                  'Number of Bookings',
                  style: GLTextStyles.poppins().copyWith(
                    fontSize: size.width * 0.035, // 14 equivalent
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                TextField(
                  controller: controller.bookingCountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter booking count',
                    prefixIcon: Icon(Icons.book, color: ColorTheme.maincolor, size: size.width * 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.025),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.025),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.025),
                      borderSide: BorderSide(color: ColorTheme.maincolor, width: 1.5),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: size.height * 0.017,
                        horizontal: size.width * 0.03
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.025),

                // Box Count TextField
                Text(
                  'Number of Boxes',
                  style: GLTextStyles.poppins().copyWith(
                    fontSize: size.width * 0.035, // 14 equivalent
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                TextField(
                  controller: controller.boxCountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter box'
                        ' count',
                    prefixIcon: Icon(Icons.inventory, color: ColorTheme.maincolor, size: size.width * 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.025),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.025),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.025),
                      borderSide: BorderSide(color: ColorTheme.maincolor, width: 1.5),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: size.height * 0.017,
                        horizontal: size.width * 0.03
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTheme.maincolor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.025),
                      ),
                    ),
                    onPressed: () => controller.submitCounts(digits, context),
                    child: Text(
                      'Submit',
                      style: GLTextStyles.poppins2().copyWith(
                        fontSize: size.width * 0.04, // 16 equivalent
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorTheme.maincolor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      Provider.of<BookingCountProvider>(context, listen: false)
          .setSelectedDate(picked);
    }
  }
}
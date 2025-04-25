import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/booking_count_screen/service/booking_count_screen_service.dart';
import '../controller/view_count_screen_controller.dart';

class ViewCountsScreen extends StatelessWidget {
  final String digits;

  const ViewCountsScreen({Key? key, required this.digits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ViewCountsController>(context);
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Counts', style: GLTextStyles.poppins2()),
        backgroundColor: ColorTheme.maincolor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Range Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Date Range',
                        style: GLTextStyles.poppins().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, isFromDate: true),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.width * 0.035,
                                  horizontal: size.width * 0.03,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: ColorTheme.maincolor,
                                      size: 20,
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    Expanded(
                                      child: Text(
                                        controller.fromDate != null
                                            ? DateFormat.yMd().format(controller.fromDate!)
                                            : 'From Date',
                                        style: GLTextStyles.poppins(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, isFromDate: false),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.width * 0.035,
                                  horizontal: size.width * 0.03,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: ColorTheme.maincolor,
                                      size: 20,
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    Expanded(
                                      child: Text(
                                        controller.toDate != null
                                            ? DateFormat.yMd().format(controller.toDate!)
                                            : 'To Date',
                                        style: GLTextStyles.poppins(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.maincolor,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, size.height * 0.055),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => controller.fetchCounts(digits, context),
                        child: Text(
                          'Search Records',
                          style: GLTextStyles.poppins2().copyWith(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              // Results heading
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text(
                  'Booking Results',
                  style: GLTextStyles.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.01),

              // Results list
              Expanded(
                child: controller.isLoading
                    ? Center(
                  child: CircularProgressIndicator(
                    color: ColorTheme.maincolor,
                  ),
                )
                    : controller.countsData == null || controller.countsData!.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No booking data available',
                        style: GLTextStyles.poppins().copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: controller.countsData!.length,
                  itemBuilder: (context, index) {
                    final item = controller.countsData![index];
                    final bookingDate = DateTime.parse(item['booking_date']);

                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          title: Text(
                            DateFormat.yMMMMd().format(bookingDate),
                            style: GLTextStyles.poppins().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                _countChip(
                                  'Bookings',
                                  '${item['booking_count']}',
                                  Icons.calendar_month,
                                  ColorTheme.maincolor.withOpacity(0.1),
                                ),
                                SizedBox(width: 12),
                                _countChip(
                                  'Boxes',
                                  '${item['box_count']}',
                                  Icons.inventory_2,
                                  ColorTheme.maincolor.withOpacity(0.1),
                                ),
                              ],
                            ),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: ColorTheme.maincolor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                color: ColorTheme.maincolor,
                              ),
                              onPressed: () => _showEditDialog(context, item, digits),
                              tooltip: 'Edit Entry',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _countChip(String label, String value, IconData icon, Color bgColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: ColorTheme.maincolor,
          ),
          SizedBox(width: 6),
          Text(
            '$label: $value',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, {required bool isFromDate}) async {
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
      if (isFromDate) {
        Provider.of<ViewCountsController>(context, listen: false)
            .setFromDate(picked);
      } else {
        Provider.of<ViewCountsController>(context, listen: false)
            .setToDate(picked);
      }
    }
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> item, String digits) {
    final controller = Provider.of<ViewCountsController>(context, listen: false);
    TextEditingController bookingController =
    TextEditingController(text: item['booking_count'].toString());
    TextEditingController boxController =
    TextEditingController(text: item['box_count'].toString());
    DateTime selectedDate = DateTime.parse(item['booking_date']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Booking Counts',
            style: GLTextStyles.poppins().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date',
                  style: GLTextStyles.poppins().copyWith(
                    fontSize: 14.0,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
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
                      selectedDate = picked;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(selectedDate),
                          style: GLTextStyles.poppins(),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: ColorTheme.maincolor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: bookingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Booking Count',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorTheme.maincolor),
                    ),
                    prefixIcon: Icon(Icons.calendar_month, color: ColorTheme.maincolor),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: boxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Box Count',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorTheme.maincolor),
                    ),
                    prefixIcon: Icon(Icons.inventory_2, color: ColorTheme.maincolor),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (bookingController.text.isEmpty || boxController.text.isEmpty) {
                  AppUtils.oneTimeSnackBar("Please enter both counts", context: context);
                  return;
                }

                try {
                  final response = await BookingCountService.updateCounts(
                    item['party_bk_id'].toString(),
                    digits,
                    selectedDate,
                    bookingController.text,
                    boxController.text,
                  );

                  if (response != null && response["status"] == 200) {
                    AppUtils.oneTimeSnackBar("Counts updated successfully",
                        context: context, bgColor: Colors.green);
                    Navigator.pop(context);
                    controller.fetchCounts(digits, context);
                  } else {
                    AppUtils.oneTimeSnackBar("Failed to update counts", context: context);
                  }
                } catch (e) {
                  AppUtils.oneTimeSnackBar("Error updating counts", context: context);
                }
              },
              child: Text(
                'Update',
                style: GLTextStyles.poppins2(),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 24),
        );
      },
    );
  }
}
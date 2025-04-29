import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/booking_count_screen/service/add_booking_count_screen_service.dart';
import '../controller/added_count_view_screen_controller.dart';

class ViewCountsScreen extends StatelessWidget {
  final String digits;

  const ViewCountsScreen({Key? key, required this.digits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ViewCountsController>(context);
    final size = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: ColorTheme.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios, color: ColorTheme.white),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('BOOKING ANALYTICS', style:GLTextStyles.mainColorTitle1(size: 18)),
        ),
        backgroundColor: ColorTheme.maincolor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // Date Range Selection Section with subtle shadow
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(size.width * 0.065),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.date_range_rounded,
                          color: ColorTheme.maincolor,
                          size: 20 * textScaleFactor,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Flexible(
                          child: Text(
                            'Select Date Range',
                            style: GLTextStyles.poppins().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14 * textScaleFactor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Use a Column for small screens
                        if (constraints.maxWidth < 340) {
                          return Column(
                            children: [
                              _buildDateSelector(
                                context,
                                isFromDate: true,
                                controller: controller,
                                width: constraints.maxWidth,
                              ),
                              SizedBox(height: size.height * 0.01),
                              _buildDateSelector(
                                context,
                                isFromDate: false,
                                controller: controller,
                                width: constraints.maxWidth,
                              ),
                            ],
                          );
                        } else {
                          // Use a Row for larger screens
                          return Row(
                            children: [
                              Expanded(
                                child: _buildDateSelector(
                                  context,
                                  isFromDate: true,
                                  controller: controller,
                                ),
                              ),
                              SizedBox(width: size.width * 0.03),
                              Expanded(
                                child: _buildDateSelector(
                                  context,
                                  isFromDate: false,
                                  controller: controller,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.maincolor,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, size.height * 0.06),
                        elevation: 3,
                        shadowColor: ColorTheme.maincolor.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(size.width * 0.025),
                        ),
                      ),
                      onPressed: () async {
                        await controller.fetchCounts(digits, context);
                      },
                      child: Text(
                        'Find Records',
                        style: GLTextStyles.poppins2().copyWith(
                          fontSize: 16.0 * textScaleFactor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Results Section
              if (controller.hasSearched) ...[
                Expanded(
                  child: controller.isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : controller.countsData == null || controller.countsData!.isEmpty
                      ? _buildEmptyState(context)
                      : _buildResultsSection(context, controller),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(
      BuildContext context, {
        required bool isFromDate,
        required ViewCountsController controller,
        double? width,
      }) {
    final size = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return InkWell(
      onTap: () => _selectDate(context, isFromDate: isFromDate),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: size.width * 0.03,
          horizontal: size.width * 0.03,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
              color: ColorTheme.maincolor,
              size: 18 * textScaleFactor,
            ),
            SizedBox(width: size.width * 0.02),
            Flexible(
              child: Text(
                isFromDate
                    ? controller.fromDate != null
                    ? DateFormat.yMMMd().format(controller.fromDate!)
                    : 'From Date'
                    : controller.toDate != null
                    ? DateFormat.yMMMd().format(controller.toDate!)
                    : 'To Date',
                style: GLTextStyles.poppins().copyWith(
                  fontSize: 13 * textScaleFactor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 50 * textScaleFactor,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'No booking data available',
              style: GLTextStyles.poppins().copyWith(
                color: Colors.grey.shade700,
                fontSize: 16.0 * textScaleFactor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'Try selecting a different date range',
              style: GLTextStyles.poppins().copyWith(
                color: Colors.grey.shade500,
                fontSize: 14.0 * textScaleFactor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection(BuildContext context, ViewCountsController controller) {
    final size = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.width * 0.04,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Booking Results',
                  style: GLTextStyles.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0 * textScaleFactor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // FIX: The container with "X Entries" text is causing overflow
              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorTheme.maincolor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${controller.countsData!.length} Entries',
                    style: GLTextStyles.poppins().copyWith(
                      color: ColorTheme.maincolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0 * textScaleFactor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.width * 0.02,
            ),
            itemCount: controller.countsData!.length,
            itemBuilder: (context, index) {
              final item = controller.countsData![index];
              final bookingDate = DateTime.parse(item['booking_date']);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      ColorTheme.maincolor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // Can be used for view details if needed
                    },
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return constraints.maxWidth < 280
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildBookingDateSection(bookingDate, textScaleFactor, size),
                                  SizedBox(height: size.height * 0.01),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _buildEditButton(context, item, digits),
                                  ),
                                ],
                              )
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: _buildBookingDateSection(bookingDate, textScaleFactor, size)),
                                  _buildEditButton(context, item, digits),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: size.height * 0.015),
                          Divider(color: Colors.grey.shade200),
                          SizedBox(height: size.height * 0.01),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Use a responsive layout based on available width
                              return constraints.maxWidth < 220
                                  ? Column(
                                children: [
                                  _countTile(
                                    'Bookings',
                                    '${item['booking_count']}',
                                    Icons.calendar_month_rounded,
                                    textScaleFactor,
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  _countTile(
                                    'Boxes',
                                    '${item['box_count']}',
                                    Icons.inventory_2_rounded,
                                    textScaleFactor,
                                  ),
                                ],
                              )
                                  : Row(
                                children: [
                                  Expanded(
                                    child: _countTile(
                                      'Bookings',
                                      '${item['booking_count']}',
                                      Icons.calendar_month_rounded,
                                      textScaleFactor,
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                  Expanded(
                                    child: _countTile(
                                      'Boxes',
                                      '${item['box_count']}',
                                      Icons.inventory_2_rounded,
                                      textScaleFactor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookingDateSection(DateTime bookingDate, double textScaleFactor, Size size) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorTheme.maincolor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.event_note_rounded,
            color: ColorTheme.maincolor,
            size: 18 * textScaleFactor,
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(bookingDate),
                style: GLTextStyles.poppins().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0 * textScaleFactor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                DateFormat.EEEE().format(bookingDate),
                style: GLTextStyles.poppins().copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12.0 * textScaleFactor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context, Map<String, dynamic> item, String digits) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: ColorTheme.maincolor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.edit_outlined,
          color: ColorTheme.maincolor,
          size: 16,
        ),
      ),
      onPressed: () => _showEditDialog(context, item, digits),
      tooltip: 'Edit Entry',
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(8),
    );
  }

  Widget _countTile(String label, String value, IconData icon, double textScaleFactor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16 * textScaleFactor,
          color: ColorTheme.maincolor,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GLTextStyles.poppins().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0 * textScaleFactor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                label,
                style: GLTextStyles.poppins().copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12.0 * textScaleFactor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
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
            dialogBackgroundColor: Colors.white,
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
    final size = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorTheme.white,
          insetPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.03,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(

            constraints: BoxConstraints(

              maxWidth: 400,
              maxHeight: size.height * 0.8,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.edit_note_rounded,
                        color: ColorTheme.maincolor,
                        size: 22 * textScaleFactor,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Flexible(
                        child: Text(
                          'Edit Counts',
                          style: GLTextStyles.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * textScaleFactor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.01),
                          Text(
                            'Select Date',
                            style: GLTextStyles.poppins().copyWith(
                              fontSize: 14.0 * textScaleFactor,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
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
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      DateFormat.yMMMMd().format(selectedDate),
                                      style: GLTextStyles.poppins().copyWith(
                                        fontSize: 14 * textScaleFactor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_today,
                                    color: ColorTheme.maincolor,
                                    size: 16 * textScaleFactor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextField(
                            controller: bookingController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Booking Count',
                              labelStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14 * textScaleFactor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: ColorTheme.maincolor),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              prefixIcon: Icon(Icons.calendar_month, color: ColorTheme.maincolor),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          TextField(
                            controller: boxController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Box Count',
                              labelStyle: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14 * textScaleFactor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: ColorTheme.maincolor),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              prefixIcon: Icon(Icons.inventory_2, color: ColorTheme.maincolor),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    overflowDirection: VerticalDirection.down,
                    overflowButtonSpacing: 8,
                    children: [
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
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: ColorTheme.maincolor.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                  context: context, bgColor: ColorTheme.maincolor,textStyle: TextStyle(color: ColorTheme.white));
                              Navigator.pop(context);
                              controller.fetchCounts(digits, context);
                            } else {
                              AppUtils.oneTimeSnackBar("Failed to update counts", context: context);
                            }
                          } catch (e) {
                            AppUtils.oneTimeSnackBar("Error updating counts", context: context);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.save_rounded, size: 16 * textScaleFactor),
                            const SizedBox(width: 8),
                            Text(
                              'Update',
                              style: GLTextStyles.poppins2().copyWith(
                                fontSize: 14 * textScaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
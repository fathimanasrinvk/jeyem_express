import 'package:jeyem_express_cargo/core/constants/text_styles.dart';

import '../../../core/constants/colors.dart';
import '../../../repository/api/common/model/details_model.dart';
import 'package:flutter/material.dart';

class ProductAndVehicleDetails extends StatelessWidget {
  final Size size;
  final List<Map<String, String>> productDetails;
  final List<DispatchDetail> vehicleDetails;

  const ProductAndVehicleDetails({
    Key? key,
    required this.size,
    required this.productDetails,
    required this.vehicleDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.01),
        Text(
          'Product Details:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: size.height * 0.021),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('ITEM',style: GLTextStyles.poppins(),)),
              DataColumn(label: Text('SIZE',style: GLTextStyles.poppins(),)),
              DataColumn(label: Text('QUANTITY',style: GLTextStyles.poppins(),)),
              DataColumn(label: Text('FREIGHT',style: GLTextStyles.poppins(),)),
            ],
            rows: productDetails.map((product) {
              return DataRow(cells: [
                DataCell(Text(product['item'] ?? '')),
                DataCell(Text(product['size'] ?? '')),
                DataCell(Text(product['quantity'] ?? '')),
                DataCell(Text(product['freight'] ?? '')),
              ]);
            }).toList(),
            border: TableBorder(
              horizontalInside: BorderSide(color: ColorTheme.secondarycolor, width: 0.5),
              verticalInside: BorderSide(color: ColorTheme.secondarycolor, width: 0.5),
              bottom: BorderSide(color: ColorTheme.secondarycolor, width: 1.0),
              top: BorderSide(color: ColorTheme.secondarycolor, width: 1.0),
              left: BorderSide(color: ColorTheme.secondarycolor, width: 1.0),
              right: BorderSide(color: ColorTheme.secondarycolor, width: 1.0),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Text(
          'Vehicle Details:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: size.height * 0.021),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('VEHICLE',style: GLTextStyles.poppins(),)),
              DataColumn(label: Text('FROM',style: GLTextStyles.poppins(),)),
              DataColumn(label: Text('DESTINATION',style: GLTextStyles.poppins(),)),
              DataColumn(label: Text('DATE',style: GLTextStyles.poppins(),)),
              DataColumn(label: Text('DISP',style: GLTextStyles.poppins(),)),
            ],
            rows: vehicleDetails.map((vehicle) {
              return DataRow(cells: [
                DataCell(Text(vehicle.vehicleNumber ?? '')),
                DataCell(Text(vehicle.from ?? '')),
                DataCell(Text(vehicle.destination ?? '')),
                DataCell(Text(vehicle.date ?? '')),
                DataCell(Text(vehicle.disp?.toString() ?? '')),
              ]);
            }).toList(),
            border: TableBorder(
              horizontalInside: BorderSide(color: ColorTheme.maincolor, width: 0.5),
              verticalInside: BorderSide(color: ColorTheme.maincolor, width: 0.5),
              bottom: BorderSide(color: ColorTheme.maincolor, width: 1.0),
              top: BorderSide(color: ColorTheme.maincolor, width: 1.0),
              left: BorderSide(color: ColorTheme.maincolor, width: 1.0),
              right: BorderSide(color: ColorTheme.maincolor, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }
}

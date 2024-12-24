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
            style: GLTextStyles.poppins(color: ColorTheme.white)        ),
        SizedBox(height: size.height * 0.021),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: ColorTheme.white,
              border: Border.all(color: ColorTheme.maincolor),
            ),
            child: DataTable(
              decoration: BoxDecoration(border: Border.all(color: ColorTheme.maincolor)),
              columns: [
                DataColumn(

                    label: Text(
                      'ITEM',
                      style: GLTextStyles.poppins(),
                    )),
                DataColumn(
                    label: Text(
                      'SIZE',
                      style: GLTextStyles.poppins(),
                    )),
                DataColumn(
                    label: Text(
                      'QUANTITY',
                      style: GLTextStyles.poppins(),
                    )),
                DataColumn(
                    label: Text(
                      'FREIGHT',
                      style: GLTextStyles.poppins(),
                    )),
              ],
              rows: productDetails.map((product) {
                return DataRow(cells: [
                  DataCell(Text(product['item'] ?? '',  style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal)),),
                  DataCell(Text(product['size'] ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                  DataCell(Text(product['quantity'] ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                  DataCell(Text(product['freight'] ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                ]);
              }).toList(),
              border: TableBorder(

                horizontalInside:
                BorderSide(color: ColorTheme.maincolor, width:  1.5),
                verticalInside:
                BorderSide(color: ColorTheme.maincolor, width: 1.5),
                bottom: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                top: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                left: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                right: BorderSide(color: ColorTheme.maincolor, width: 1.0),
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Text(
            'Vehicle Details:',
            style: GLTextStyles.poppins(color: ColorTheme.white)
        ),
        SizedBox(height: size.height * 0.021),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: ColorTheme.white,
              border: Border.all(color: ColorTheme.maincolor),
            ),

            child: DataTable(
              columns: [
                DataColumn(
                    label: Text(
                      'VEHICLE',
                      style: GLTextStyles.poppins(),
                    )),
                DataColumn(
                    label: Text(
                      'FROM',
                      style: GLTextStyles.poppins(),
                    )),
                DataColumn(
                    label: Text(
                      'DESTINATION',
                      style: GLTextStyles.poppins(),
                    )),
                DataColumn(
                    label: Text(
                      'DATE',
                      style: GLTextStyles.poppins(),
                    )),
                DataColumn(
                    label: Text(
                      'DISP',
                      style: GLTextStyles.poppins(),
                    )),
              ],
              rows: vehicleDetails.map((vehicle) {
                return DataRow(cells: [
                  DataCell(Text(vehicle.vehicleNumber ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                  DataCell(Text(vehicle.from ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                  DataCell(Text(vehicle.destination ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                  DataCell(Text(vehicle.date ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                  DataCell(Text(vehicle.disp?.toString() ?? '', style:GLTextStyles.textformfieldhint(size: 16,weight: FontWeight.normal))),
                ]);
              }).toList(),
              border: TableBorder(
                horizontalInside:
                BorderSide(color: ColorTheme.maincolor, width: 1.5),
                verticalInside:
                BorderSide(color: ColorTheme.maincolor, width: 1.5),
                bottom: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                top: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                left: BorderSide(color: ColorTheme.maincolor, width: 1.0),
                right: BorderSide(color: ColorTheme.maincolor, width: 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
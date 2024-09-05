import 'package:intl/intl.dart';
import 'dart:developer';
import '../../../helper/api_helper.dart';

class PartyViewService {
  static Future<dynamic> fetchDetailData(String digits, DateTime fromDate, DateTime toDate) async {
    log("PartyViewService -> fetchDetailData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "partybookingget/$digits/${DateFormat('yyyy-MM-dd').format(fromDate)}/${DateFormat('yyyy-MM-dd').format(toDate)}",
      );
      return decodedData;
    } catch (e) {
      log("Error fetching data: $e");
      rethrow;
    }
  }
}

import 'package:intl/intl.dart';
import 'dart:developer';
import '../../../helper/api_helper.dart';

class PartyViewService {
  static Future<dynamic> fetchDetailData(String digits, DateTime fromDate, ) async {
    log("PartyViewService -> fetchDetailData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "partybookingget/$digits/${DateFormat('yyyy-MM-dd').format(fromDate)}",
      );
      return decodedData;
    } catch (e) {
      log("Error fetching data: $e");
      rethrow;
    }
  }
}
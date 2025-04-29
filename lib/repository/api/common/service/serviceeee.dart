import 'dart:developer';
import '../../../helper/api_helper.dart';

class TrackDetailsService {
  static Future<dynamic> fetchDetailData(String trackNumber) async {
    log("TrackDetailsService -> fetchDetailData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "bookinglrsearch/$trackNumber",
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}

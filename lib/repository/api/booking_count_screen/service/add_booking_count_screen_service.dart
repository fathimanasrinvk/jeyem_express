import 'package:intl/intl.dart';
import '../../../helper/api_helper.dart';

class BookingCountService {
  static Future<dynamic> submitCounts(
      String digits,
      DateTime date,
      String bookingCount,
      String boxCount,
      ) async {
    try {
      var decodedData = await ApiHelper.postData(
        endPoint: "party-insert-box-count",
        body: {
          "party_id": digits,
          "booking_date": DateFormat('yyyy-MM-dd').format(date),
          "booking_count": bookingCount,
          "box_count": boxCount,
        },
      );
      return decodedData;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> updateCounts(
      String id,
      String digits,
      DateTime date,
      String bookingCount,
      String boxCount,
      ) async {
    try {
      var decodedData = await ApiHelper.postData(
        endPoint: "party-insert-box-count",
        body: {
          "party_bk_id": id,
          "party_id": digits,
          "booking_date": DateFormat('yyyy-MM-dd').format(date),
          "booking_count": bookingCount,
          "box_count": boxCount,
        },
      );
      return decodedData;
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> getCounts(
      String digits, DateTime fromDate, DateTime toDate) async {
    try {
      var decodedData = await ApiHelper.getData(
        endPoint:
        "party-get-box-count?party_id=$digits&from_date=${DateFormat('yyyy-MM-dd').format(fromDate)}&to_date=${DateFormat('yyyy-MM-dd').format(toDate)}",
      );
      return decodedData;
    } catch (e) {
      rethrow;
    }
  }
}
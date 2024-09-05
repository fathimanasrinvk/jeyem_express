
// To parse this JSON data, do
//
//     final partyViewModel = partyViewModelFromJson(jsonString);

import 'dart:convert';

PartyViewModel partyViewModelFromJson(String str) => PartyViewModel.fromJson(json.decode(str));

String partyViewModelToJson(PartyViewModel data) => json.encode(data.toJson());

class PartyViewModel {
  String? status;
  List<Datum>? data;

  PartyViewModel({
    this.status,
    this.data,
  });

  factory PartyViewModel.fromJson(Map<String, dynamic> json) => PartyViewModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? consignorName;
  String? consigneeName;
  String? lrNumber;
  String? bookingDate;
  String? invoiceNo;
  String? endStationName;
  int? noBoxes;
  String? paymentType;
  String? bookingStatus;
  String? deliveryDate;

  Datum({
    this.consignorName,
    this.consigneeName,
    this.lrNumber,
    this.bookingDate,
    this.invoiceNo,
    this.endStationName,
    this.noBoxes,
    this.paymentType,
    this.bookingStatus,
    this.deliveryDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    consignorName: json["consignor_name"],
    consigneeName: json["consignee_name"],
    lrNumber: json["lr_number"],
    bookingDate: json["booking_date"],
    invoiceNo: json["invoice_no"],
    endStationName: json["end_station_name"],
    noBoxes: json["no_boxes"],
    paymentType: json["payment_type"],
    bookingStatus: json["booking_status"],
    deliveryDate: json["delivery_date"],
  );

  Map<String, dynamic> toJson() => {
    "consignor_name": consignorName,
    "consignee_name": consigneeName,
    "lr_number": lrNumber,
    "booking_date": bookingDate,
    "invoice_no": invoiceNo,
    "end_station_name": endStationName,
    "no_boxes": noBoxes,
    "payment_type": paymentType,
    "booking_status": bookingStatus,
    "delivery_date": deliveryDate,
  };
}



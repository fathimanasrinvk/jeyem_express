// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  String? status;
  Booking? booking;
  ConsignParty? consignorParty;
  ConsignParty? consigneeParty;
  ItemDetails? itemDetails;
  List<DispatchDetail>?   dispatchDetails;

  DetailsModel({
    this.status,
    this.booking,
    this.consignorParty,
    this.consigneeParty,
    this.itemDetails,
    this.dispatchDetails,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        status: json["status"],
        booking:
            json["booking"] == null ? null : Booking.fromJson(json["booking"]),
        consignorParty: json["consignor_party"] == null
            ? null
            : ConsignParty.fromJson(json["consignor_party"]),
        consigneeParty: json["consignee_party"] == null
            ? null
            : ConsignParty.fromJson(json["consignee_party"]),
        itemDetails: json["item_details"] == null
            ? null
            : ItemDetails.fromJson(json["item_details"]),
        dispatchDetails: json["dispatch_details"] == null
            ? []
            : List<DispatchDetail>.from(json["dispatch_details"]!
                .map((x) => DispatchDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "booking": booking?.toJson(),
        "consignor_party": consignorParty?.toJson(),
        "consignee_party": consigneeParty?.toJson(),
        "item_details": itemDetails?.toJson(),
        "dispatch_details": dispatchDetails == null
            ? []
            : List<dynamic>.from(dispatchDetails!.map((x) => x.toJson())),
      };
}

class Booking {
  int? bookingId;
  String? lrNumber;
  String? dsrDelivery;
  int? lrCharge;
  double? freight;
  int? extraCharge;
  double? total;
  double? gstAmount;
  int? billDiscount;
  double? netTotal;
  dynamic deliveryRemarks;
  String? bookedOn;
  String? bookedAt;
  String? paymentMode;
  String? invoiceNo;
  String? gstInvoice;
  String? bookedBy;
  String? deliveryDate;

  Booking({
    this.bookingId,
    this.lrNumber,
    this.dsrDelivery,
    this.lrCharge,
    this.freight,
    this.extraCharge,
    this.total,
    this.gstAmount,
    this.billDiscount,
    this.netTotal,
    this.deliveryRemarks,
    this.bookedOn,
    this.bookedAt,
    this.paymentMode,
    this.invoiceNo,
    this.gstInvoice,
    this.bookedBy,
    this.deliveryDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        bookingId: json["booking_id"],
        lrNumber: json["lr_number"],
        dsrDelivery: json["dsr_delivery"],
        lrCharge: json["lr_charge"],
        freight: json["freight"]?.toDouble(),
        extraCharge: json["extra_charge"],
        total: json["total"]?.toDouble(),
        gstAmount: json["gst_amount"]?.toDouble(),
        billDiscount: json["bill_discount"],
        netTotal: json["net_total"]?.toDouble(),
        deliveryRemarks: json["delivery_remarks"],
        bookedOn: json["booked_on"],
        bookedAt: json["booked_at"],
        paymentMode: json["payment_mode"],
        invoiceNo: json["invoice_no"],
        gstInvoice: json["gst_invoice"],
        bookedBy: json["booked_by"],
        deliveryDate: json["delivery_date"]
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "lr_number": lrNumber,
        "dsr_delivery": dsrDelivery,
        "lr_charge": lrCharge,
        "freight": freight,
        "extra_charge": extraCharge,
        "total": total,
        "gst_amount": gstAmount,
        "bill_discount": billDiscount,
        "net_total": netTotal,
        "delivery_remarks": deliveryRemarks,
        "booked_on": bookedOn,
        "booked_at": bookedAt,
        "payment_mode": paymentMode,
        "invoice_no": invoiceNo,
        "gst_invoice": gstInvoice,
        "booked_by": bookedBy,
        "delivery_date": deliveryDate,
      };
}

class ConsignParty {
  String? partyName;
  String? station;
  String? address;
  String? gst;
  String? phone;
  dynamic email;

  ConsignParty({
    this.partyName,
    this.station,
    this.address,
    this.gst,
    this.phone,
    this.email,
  });

  factory ConsignParty.fromJson(Map<String, dynamic> json) => ConsignParty(
        partyName: json["party_name"],
        station: json["station"],
        address: json["address"],
        gst: json["gst"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "party_name": partyName,
        "station": station,
        "address": address,
        "gst": gst,
        "phone": phone,
        "email": email,
      };
}

class DispatchDetail {
  String? vehicleNumber;
  String? from;
  String? destination;
  String? date;
  int? disp;

  DispatchDetail({
    this.vehicleNumber,
    this.from,
    this.destination,
    this.date,
    this.disp,
  });

  factory DispatchDetail.fromJson(Map<String, dynamic> json) => DispatchDetail(
        vehicleNumber: json["vehicle_number"],
        from: json["from"],
        destination: json["destination"],
        date: json["date"],
        disp: json["disp"],
      );

  Map<String, dynamic> toJson() => {
        "vehicle_number": vehicleNumber,
        "from": from,
        "destination": destination,
        "date": date,
        "disp": disp,
      };
}

class ItemDetails {
  String? item;
  String? size;
  int? quantity;
  double? freight;

  ItemDetails({
    this.item,
    this.size,
    this.quantity,
    this.freight,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) => ItemDetails(
        item: json["item"],
        size: json["size"],
        quantity: json["quantity"],
        freight: json["freight"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "size": size,
        "quantity": quantity,
        "freight": freight,
      };
}

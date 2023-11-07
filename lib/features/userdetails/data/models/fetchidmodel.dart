// To parse this JSON data, do
//
//     final fetchIdregisteredModel = fetchIdregisteredModelFromJson(jsonString);

import 'dart:convert';

FetchIdregisteredModel fetchIdregisteredModelFromJson(String str) => FetchIdregisteredModel.fromJson(json.decode(str));

String fetchIdregisteredModelToJson(FetchIdregisteredModel data) => json.encode(data.toJson());

class FetchIdregisteredModel {
    String success;
    Data data;

    FetchIdregisteredModel({
        required this.success,
        required this.data,
    });

    factory FetchIdregisteredModel.fromJson(Map<String, dynamic> json) => FetchIdregisteredModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    List<Prev> prev;

    Data({
        required this.prev,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        prev: List<Prev>.from(json["prev"].map((x) => Prev.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "prev": List<dynamic>.from(prev.map((x) => x.toJson())),
    };
}

class Prev {
    String? id;
    String? firstname;
    String? lastname;
    String? email;
    String? phone;
    String? password;
    String? referee;
    bool? confirmed;
    bool? verified;
    String? referalid;
    String? location;
    String? address;
    DateTime? date;
    int? v;
    String? loggedstamp;
    String? token;
    int? numberrefer;
    bool? subscribed;

    Prev({
        this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.phone,
        this.password,
        this.referee,
        this.confirmed,
        this.verified,
        this.referalid,
        this.location,
        this.address,
        this.date,
        this.v,
        this.loggedstamp,
        this.token,
        this.numberrefer,
        this.subscribed,
    });

    factory Prev.fromJson(Map<String, dynamic> json) => Prev(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        referee: json["referee"],
        confirmed: json["confirmed"],
        verified: json["verified"],
        referalid: json["referalid"],
        location: json["location"],
        address: json["address"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        v: json["__v"],
        loggedstamp: json["loggedstamp"],
        token: json["token"],
        numberrefer: json["numberrefer"],
        subscribed: json["subscribed"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "password": password,
        "referee": referee,
        "confirmed": confirmed,
        "verified": verified,
        "referalid": referalid,
        "location": location,
        "address": address,
        "date": date?.toIso8601String(),
        "__v": v,
        "loggedstamp": loggedstamp,
        "token": token,
        "numberrefer": numberrefer,
        "subscribed": subscribed,
    };
}

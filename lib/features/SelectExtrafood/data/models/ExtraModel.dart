// To parse this JSON data, do
//
//     final extrasModel = extrasModelFromJson(jsonString);

import 'dart:convert';

ExtrasModel extrasModelFromJson(String str) => ExtrasModel.fromJson(json.decode(str));

String extrasModelToJson(ExtrasModel data) => json.encode(data.toJson());

class ExtrasModel {
    List<ItemExtra> itemExtra;

    ExtrasModel({
        required this.itemExtra,
    });

    factory ExtrasModel.fromJson(Map<String, dynamic> json) => ExtrasModel(
        itemExtra: List<ItemExtra>.from(json["itemExtra"].map((x) => ItemExtra.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "itemExtra": List<dynamic>.from(itemExtra.map((x) => x.toJson())),
    };
}

class ItemExtra {
    String id;
    String itemExtraId;
    String item;
    bool availability;
    bool remaining;
    String remainingInt;
    String imageUrl;
    List<String> extras;
    int v;
    String mincost;
    bool extraable;
    int maxspoon;
    String? segment;

    ItemExtra({
        required this.id,
        required this.itemExtraId,
        required this.item,
        required this.availability,
        required this.remaining,
        required this.remainingInt,
        required this.imageUrl,
        required this.extras,
        required this.v,
        required this.mincost,
        required this.extraable,
        required this.maxspoon,
        this.segment,
    });

    factory ItemExtra.fromJson(Map<String, dynamic> json) => ItemExtra(
        id: json["_id"],
        itemExtraId: json["id"],
        item: json["item"],
        availability: json["availability"],
        remaining: json["remaining"],
        remainingInt: json["remainingINT"],
        imageUrl: json["image_url"],
        extras: List<String>.from(json["extras"].map((x) => x)),
        v: json["__v"],
        mincost: json["mincost"],
        extraable: json["extraable"],
        maxspoon: json["maxspoon"],
        segment: json["segment"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "id": itemExtraId,
        "item": item,
        "availability": availability,
        "remaining": remaining,
        "remainingINT": remainingInt,
        "image_url": imageUrl,
        "extras": List<dynamic>.from(extras.map((x) => x)),
        "__v": v,
        "mincost": mincost,
        "extraable": extraable,
        "maxspoon": maxspoon,
        "segment": segment,
    };
}

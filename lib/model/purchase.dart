import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  final String? id;
  final List items;
  final String name;
  final String email;
  final int phone;
  final String address;
  final DateTime? dateTime;

  PurchaseModel({
    this.id,
    required this.items,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.dateTime,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json, String id) =>
      PurchaseModel(
        id: id,
        items: json['items'] as List,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as int,
        address: json['address'] as String,
        dateTime: (json['dateTime'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        'items': items,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'dateTime': dateTime ?? DateTime.now(),
      };
}

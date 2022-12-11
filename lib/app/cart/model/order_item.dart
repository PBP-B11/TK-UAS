// To parse this JSON data, do
//
//     final orderItem = orderItemFromJson(jsonString);

import 'dart:convert';
import 'package:my_panel/app/product_list/models/product.dart';

List<OrderItem> orderItemFromJson(String str) => List<OrderItem>.from(json.decode(str).map((x) => OrderItem.fromJson(x)));

String orderItemToJson(List<OrderItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderItem {
  OrderItem({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  Fields({
    required this.product,
    required this.order,
    required this.quantity,
    required this.dateAdded,
  });

  Product product;
  Order order;
  int quantity;
  DateTime dateAdded;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    product: Product.fromJson(json["product"]),
    order: Order.fromJson(json["order"]),
    quantity: json["quantity"],
    dateAdded: DateTime.parse(json["date_added"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "order": order.toJson(),
    "quantity": quantity,
    "date_added": dateAdded.toIso8601String(),
  };
}

class Order {
  Order({
    required this.customer,
    required this.dateOrdered,
    required this.isComplete,
    this.transactionId,
  });

  int customer;
  DateTime dateOrdered;
  int isComplete;
  dynamic transactionId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    customer: json["customer"],
    dateOrdered: DateTime.parse(json["date_ordered"]),
    isComplete: json["is_complete"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "customer": customer,
    "date_ordered": dateOrdered.toIso8601String(),
    "is_complete": isComplete,
    "transaction_id": transactionId,
  };
}

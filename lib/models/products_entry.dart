// To parse this JSON data, do
//
//     final productsEntry = productsEntryFromJson(jsonString);

import 'dart:convert';

List<ProductsEntry> productsEntryFromJson(String str) => List<ProductsEntry>.from(json.decode(str).map((x) => ProductsEntry.fromJson(x)));

String productsEntryToJson(List<ProductsEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsEntry {
    String name;
    String description;
    String category;
    String thumbnail;
    bool isFeatured;
    String brand;
    int price;
    int id;
    int? userId;
    String? authorUsername;

    ProductsEntry({
        required this.name,
        required this.description,
        required this.category,
        required this.thumbnail,
        required this.isFeatured,
        required this.brand,
        required this.price,
        required this.id,
        required this.userId,
        this.authorUsername,
    });

    factory ProductsEntry.fromJson(Map<String, dynamic> json) => ProductsEntry(
        name: json["name"],
        description: json["description"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        isFeatured: json["is_featured"],
        brand: json["brand"],
        price: json["price"],
        id: json["id"],
        userId: json["user_id"],
        authorUsername: json["user_username"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "is_featured": isFeatured,
        "brand": brand,
        "price": price,
        "id": id,
        "user_id": userId,
        "user_username": authorUsername,
    };
}

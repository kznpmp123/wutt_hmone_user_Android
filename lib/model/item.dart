class ItemModel {
  final String? id;
  final String photo;
  final String desc;
  final String name;
  final int price;

  final String color;
  final String size;
  final int star;
  final String category;
  // final DateTime? created;

  ItemModel({
    this.id,
    required this.photo,
    required this.name,
    required this.price,
    required this.desc,
    required this.color,
    required this.size,
    required this.star,
    required this.category,
    // this.created,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json, id) => ItemModel(
        id: id,
        photo: json['photo'] as String,
        name: json['name'] as String,
        desc: json['desc'] as String,
        price: json['price'] as int,
        color: json['color'] as String,
        size: json['size'] as String,
        star: json['star'] as int,
        category: json['category'] as String,
      );

  Map<String, dynamic> toJson() => {
        'photo': photo,
        'name': name,
        'price': price,
        'color': color,
        'size': size,
        'star': star,
        'category': category,
        'desc': desc,
      };

  ItemModel copyWith({
    String? newPhoto,
    String? newName,
    String? des,
    int? newPrice,
    String? newColor,
    String? newSize,
    int? newStar,
    String? newCategory,
  }) =>
      ItemModel(
        id: id,
        photo: newPhoto ?? photo,
        name: newName ?? name,
        price: newPrice ?? price,
        desc: des ?? desc,
        color: newColor ?? color,
        size: newSize ?? size,
        star: newStar ?? star,
        category: newCategory ?? category,
      );
}

class PurchaseItem {
  final String id;
  final int count;
  final String size;
  final String color;

  PurchaseItem(this.id, this.count, this.size, this.color);
}

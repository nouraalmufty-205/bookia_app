class BookDetailsModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final int stock;
  final int discount;
  final double priceAfterDiscount;
  final String image;
  final String category;
  final String special;

  BookDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.discount,
    required this.priceAfterDiscount,
    required this.image,
    required this.category,
    required this.special,
  });

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '0',
      stock: json['stock'] ?? 0,
      discount: json['discount'] ?? 0,
      priceAfterDiscount:
          (json['price_after_discount'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      special: json['special'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'stock': stock,
    'discount': discount,
    'price_after_discount': priceAfterDiscount,
    'image': image,
    'category': category,
    'special': special,
  };
}

class BookDetailsResponse {
  final BookDetailsModel? data;
  final String message;

  final int status;

  BookDetailsResponse({this.data, required this.message, required this.status});

  factory BookDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BookDetailsResponse(
      data: json['data'] != null
          ? BookDetailsModel.fromJson(json['data'])
          : null,
      message: json['message'] ?? '',

      status: json['status'] ?? 0,
    );
  }
}

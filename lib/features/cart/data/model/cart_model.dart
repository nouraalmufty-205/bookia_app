class CartResponseModel {
  final CartModel? data;
  final String? message;
  final int? status;

  CartResponseModel({this.data, this.message, this.status});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      data: json['data'] != null ? CartModel.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }
}

class CartModel {
  final int? id;
  final CartUser? user;
  final String? total;
  final List<CartItem>? cartItems;

  CartModel({this.id, this.user, this.total, this.cartItems});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      user: json['user'] != null ? CartUser.fromJson(json['user']) : null,
      total: json['total']?.toString(),
      cartItems: (json['cart_items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e))
          .toList(),
    );
  }
}

class CartUser {
  final int? userId;
  final String? userName;

  CartUser({this.userId, this.userName});

  factory CartUser.fromJson(Map<String, dynamic> json) {
    return CartUser(
      userId: json['user_id'],
      userName: json['user_name'],
    );
  }
}

class CartItem {
  final int? itemId;
  final int? itemProductId;
  final String? itemProductName;
  final String? itemProductImage;
  final String? itemProductPrice;
  final int? itemProductDiscount;
  final double? itemProductPriceAfterDiscount;
  final int? itemProductStock;
  int itemQuantity;
  final double? itemTotal;

  CartItem({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity = 1,
    this.itemTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['item_id'],
      itemProductId: json['item_product_id'],
      itemProductName: json['item_product_name'],
      itemProductImage: json['item_product_image'],
      itemProductPrice: json['item_product_price']?.toString(),
      itemProductDiscount: json['item_product_discount'],
      itemProductPriceAfterDiscount:
          (json['item_product_price_after_discount'] as num?)?.toDouble(),
      itemProductStock: json['item_product_stock'],
      itemQuantity: json['item_quantity'] ?? 1,
      itemTotal: (json['item_total'] as num?)?.toDouble(),
    );
  }
}


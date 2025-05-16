import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/model/shop_item.dart';

class ShopItemsResponse {
  final List<ShopItem> list;
  final bool error;
  final bool isLoading;

  ShopItemsResponse({required this.list, required this.error, required this.isLoading});

  factory ShopItemsResponse.error(){
    return ShopItemsResponse(list: [], error: true, isLoading: false);
  }

  factory ShopItemsResponse.init(){
    return ShopItemsResponse(list: [], error: false, isLoading: false);
  }

  factory ShopItemsResponse.loading(){
    return ShopItemsResponse(list: [], error: false, isLoading: true);
  }

  static List<ShopItem> listFromJson(dynamic json) {
    final products = json['products'] as List<dynamic>;
    return products.map((item) => ShopItem.decodeJson(item)).toList();
  }

  ShopItemsResponse copyWith({
    List<ShopItem>? list,
    bool? error,
    bool? isLoading,
  }) {
    return ShopItemsResponse(
      list: list ?? this.list,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
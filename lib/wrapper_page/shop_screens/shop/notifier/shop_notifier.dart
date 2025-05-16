import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/services/http_service.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/model/shop_item.dart';
import '../../../../commons/constants.dart';
import '../model/shop_items_response.dart';

class ShopNotifier extends StateNotifier<ShopItemsResponse>{
  List<ShopItem> _cache = [];
  final HttpService _httpService = HttpService(baseUrl: Constants.baseUrl, info: "LOAD_PRODUCTS");
  ShopNotifier() : super(ShopItemsResponse.init());

  Future<void> fetchProducts() async {

    if (_cache.isNotEmpty){
        state = state.copyWith(list: _cache, isLoading: false);
    } else {
      try {
        state = state.copyWith(isLoading: true);
        List<ShopItem> shopItemsList = await _httpService.fetchData(ShopItemsResponse.listFromJson);
        _cache = shopItemsList;
        state = state.copyWith(list: shopItemsList, isLoading: false);
      } catch (e) {
        state = ShopItemsResponse.error();
      }
    }
  }

  void addFavorite(ShopItem item){
    if (_cache.contains(item)){
      print ("add favorite");
      int index = _cache.indexOf(item);
      _cache[index] = item;
      state = state.copyWith(list: _cache);
    }

  }

  void removeFavorite(ShopItem item){
    if (_cache.contains(item)){
      print ("remove favorite");
      _cache.remove(item);
      state = state.copyWith(list: _cache);
    }

  }
}
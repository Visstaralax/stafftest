import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/model/shop_item.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/model/shop_items_response.dart';
import '../../../../commons/image_loader.dart';
import '../notifier/shop_notifier.dart';
import 'favorite_widget.dart';

final shopProvider = StateNotifierProvider<ShopNotifier, ShopItemsResponse>((ref){
  return ShopNotifier();
});

class ShopItemWidget extends ConsumerStatefulWidget{
  final ShopItem shopItem;
  const ShopItemWidget({super.key, required this.shopItem});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ShopItemWidgetState();

}

class ShopItemWidgetState extends ConsumerState<ShopItemWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 4)
          ),
        ],
      ),
      child: Scaffold(
          body: Center(
            child: Column(
              children: [
                ...getTopContainer(),
                getDivider(),
                getBottomContainer()
              ]
                ),
          )),
    );
  }

  void _setFavoriteValue(bool isFavorite){
    print ("favorite");
    widget.shopItem.isFavorite = isFavorite;

    if (isFavorite){
      ref.read(shopProvider.notifier).addFavorite(widget.shopItem);
    } else {
      ref.read(shopProvider.notifier).removeFavorite(widget.shopItem);
    }
  }

  List<Widget> getTopContainer(){
    return [
      FavoriteWidget(initialValue: false, onChangeValue: _setFavoriteValue),
      ImageLoader(
          imageUrl: widget.shopItem.imagePath,
          width: 150,
          height: 150),
      SizedBox(height: 10),
    ];
  }

  Widget getDivider(){
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15),
      child: Divider(),
    );
  }

  Widget getBottomContainer(){
    return Row(
      children: [
          Expanded(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Text(widget.shopItem.name,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyLarge)

                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 20.0),
                        child: Text(widget.shopItem.description,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyMedium)
                    ))
              ]
            ),
          ),
          Text ("${widget.shopItem.price.toString()} €", style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1)
      ]
    );
  }
}
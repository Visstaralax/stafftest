import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/commons/loading_widget/loading_manager.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/model/shop_item.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/model/shop_items_response.dart';
import 'package:staffseidorapptest/wrapper_page/shop_screens/shop/notifier/shop_notifier.dart';

import '../../../commons/loading_widget/loading_dialog.dart';
import 'model/shop_item_widget.dart';

final shopProvider = StateNotifierProvider<ShopNotifier, ShopItemsResponse>((ref){
  return ShopNotifier();
});

class ShopScreen extends ConsumerStatefulWidget{
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();

}

class _ShopScreenState extends ConsumerState<ShopScreen>{
  List<ShopItem> products = [];

  late GlobalKey<LoadingDialogState> loadingDialogKey = GlobalKey<LoadingDialogState>();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _requestProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<ShopItemsResponse>(shopProvider, (previous, next) {
      if (next.isLoading && !(previous?.isLoading ?? false)) {
        LoadingManager.showLoadingDialog(context, loadingDialogKey);
      } else {
        if (context.mounted) {
          LoadingManager.stopLoading(context, loadingDialogKey);
        }
      }
    });

    return Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          Center(child: Text("T-shirt Staff", style: Theme.of(context).textTheme.titleLarge)),
          getContentShop()
        ]
      )
    ));
  }
  Widget getContentShop(){
      if (ref.watch(shopProvider).error){
        return Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Column(
            children: [
              Icon(Icons.mood_bad_outlined),
              SizedBox(height: 10),
              Text("No hay nada que mostrar"),
            ],
          ),
        );
      } else {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ref.watch(shopProvider).list.length,
          itemBuilder: (context, index) {
            return ShopItemWidget(shopItem: ref.watch(shopProvider).list[index]);
          }
        );
      }
  }

  Future<void> _requestProducts() async {

    await ref.read(shopProvider.notifier).fetchProducts();

    if (ref.watch(shopProvider).error && context.mounted) {
      LoadingManager.showError(context);
    }

  }

}
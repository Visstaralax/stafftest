import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget{
  final bool initialValue;
  final Function onChangeValue;
  const FavoriteWidget({super.key, required this.initialValue, required this.onChangeValue});
  @override
  State<StatefulWidget> createState() => FavoriteWidgetState();

}

class FavoriteWidgetState extends State<FavoriteWidget>{
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialValue;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Spacer(),
          IconButton(
              onPressed: (){
                setState(()=>isFavorite = !isFavorite);
                widget.onChangeValue(isFavorite);
              },
              icon: (isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_outline)))
        ]);
  }

}
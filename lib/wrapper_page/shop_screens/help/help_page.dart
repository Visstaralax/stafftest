import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staffseidorapptest/commons/ImageLoader.dart';

import '../../../commons/constants.dart';

class HelpPage extends StatefulWidget{

  const HelpPage({super.key});
  @override
  State<StatefulWidget> createState() => HelpPageState();

}

class HelpPageState extends State<HelpPage>{
  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Center(
            child: SizedBox(
                width: 200,
                height: 200,
                child: ImageLoader(imageUrl: Images.help, width: 200, height: 200)
            ),
          ),
          Text("Aqui explicamos...", style: Theme.of(context).textTheme.bodyLarge)
        ],
      );
  }

}
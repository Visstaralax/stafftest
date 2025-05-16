import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({required super.key});

  @override
  State<LoadingDialog> createState() => LoadingDialogState();

}

class LoadingDialogState extends State<LoadingDialog> {

  bool stopped = false;

  Future<void> stopLoading(BuildContext context) async {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        print ("POP");
        stopped = true;
        Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
      return SimpleDialog(
          backgroundColor: Colors.white.withAlpha(20),
          children: [
            Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
      ]);
  }
}
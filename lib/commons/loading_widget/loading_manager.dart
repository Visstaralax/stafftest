import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../dialog_type.dart';
import '../general_dialog.dart';
import 'loading_dialog.dart';

class LoadingManager {
  static void showLoadingDialog(BuildContext context, Key key) {

    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (BuildContext context){
        return AbsorbPointer(
            absorbing: true,
            child: LoadingDialog(key: key));
      });
    });
  }

  static Future<void> stopLoading(BuildContext context, GlobalKey<LoadingDialogState> loadingDialogKey) async {
    if (!context.mounted) {print ("!MOUNTED"); return; }
    print ("stop loading ${loadingDialogKey.currentState}");
    await loadingDialogKey.currentState?.stopLoading(context);
  }

  static showError(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (BuildContext context){
        return GeneralDialog(dialogType: DialogType.knowError);
      });
    });
  }
}
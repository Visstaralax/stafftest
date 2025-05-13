import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staffseidorapptest/commons/dialog_type.dart';

class GeneralDialogWithButtons extends StatefulWidget {

  final DialogType dialogType;
  const GeneralDialogWithButtons({super.key, required this.dialogType});

  @override
  State<GeneralDialogWithButtons> createState() => GeneralDialogWithButtonsState();

}

class GeneralDialogWithButtonsState extends State<GeneralDialogWithButtons> {

  var alertContent = DialogContent.empty();

  @override
  Widget build(BuildContext context) {
    switch (widget.dialogType){
      case DialogType.connectivity: {
        alertContent = DialogData.connectivityError;
        break;
      }
      case DialogType.knowError:{
        alertContent = DialogData.knowError;
        break;
      }
      case DialogType.none:{
        break;
      }

    }

    return AlertDialog(
      title: Text(alertContent.title),
      content: Text(alertContent.message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(alertContent.nameButton),
        ),
      ],
    );
  }
}

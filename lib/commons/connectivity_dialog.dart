import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ConnectivityDialog extends StatefulWidget {
  const ConnectivityDialog({super.key});

  @override
  State<ConnectivityDialog> createState() => ConnectivityDialogState();

}

class ConnectivityDialogState extends State<ConnectivityDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: const Text("No tienes conexión a internet"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Aceptar"),
        ),
      ],
    );
  }
}

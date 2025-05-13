import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/login/login_page.dart';

class LogoutNotifier extends StateNotifier<void> {
  LogoutNotifier() : super(null);

  Future<void> call(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            LoginScreen())
    );
  }
}
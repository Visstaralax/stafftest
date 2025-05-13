import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/commons/check_internet.dart';
import 'package:staffseidorapptest/commons/constants.dart';
import 'package:staffseidorapptest/commons/loading_dialog.dart';
import 'package:staffseidorapptest/login/notifier/login_notifier.dart';
import 'package:staffseidorapptest/shop/wrapper_screen.dart';

import '../commons/connectivity_dialog.dart';
import '../commons/error_dialog.dart';
import '../services/http_service.dart';
import 'model/login_response.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginResponse>((ref){
  return LoginNotifier();
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final GlobalKey<LoadingDialogState> loadingDialogKey = GlobalKey<LoadingDialogState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final loginConsumer = ref.watch(loginProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 200, width: 200, child: Image.asset(Constants.logo)),
            getTextField(userController,"Usuario", "Introduce tu nombre", Icons.supervised_user_circle, false),
            SizedBox(height: 20),
            getTextField(passController,"Contraseña", "Introduce la contraseña", Icons.password_rounded, true),
            SizedBox(height: 20),
            loading ? SizedBox(width: 25, height: 25, child: Text("")) : SizedBox(height:25, child: Text(loginConsumer.message)),
            SizedBox(height: 40),
            SizedBox(height: 50, width:100, child: ElevatedButton(onPressed: (){makeLogin(ref);
              }, child: Text("LOGIN"))),
          ],
        ),
      ),
    );
  }

  @override

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });

    checkConnectivity();
  }

  void showErrorConnectivity() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (BuildContext context){
        return ConnectivityDialog();
      });
    });
  }

  void checkConnectivity() async {
    if (!await CheckInternet.checkConnectivity()){
      showErrorConnectivity();
    }
  }

  Widget getTextField(TextEditingController controller, String labelText, String hintText, IconData icon, bool isObscure){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 4),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.blue),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        ),
      ),
    );
  }

  void showLoadingDialog() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (BuildContext context){
        return LoadingDialog(key: loadingDialogKey);
      });
    });
  }

  void showError() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (BuildContext context){
        return ErrorDialog();
      });
    });
  }

  void makeLogin(WidgetRef ref) async {

    var error = false;

    try {
      showLoadingDialog();
      await ref.read(loginProvider.notifier).makeLogin(userController.text, passController.text);
    } catch (e, st) {
      error = true;
    } finally {
      await loadingDialogKey.currentState?.stopLoading(context);
    }

    if (error){
      showError();
    } else {
      if (ref.watch(loginProvider).success){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            _createCustomRoute( WrapperScreen()),
          );
        });
      }
    }
  }

  void setLoadingState(value){
    setState(() {
      loading = value;
    });
  }

  Route _createCustomRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(10.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
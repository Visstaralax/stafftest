import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/commons/error_dialog.dart';
import 'package:staffseidorapptest/commons/loading_dialog.dart';
import 'package:staffseidorapptest/shop/shop_screens/profile/notifier/profile_notifier.dart';

import 'model/profile_response.dart';

final profileNotifier = NotifierProvider<ProfileNotifier, ProfileResponse>(() {
  return ProfileNotifier();
});

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreen();
}

final profileProvider = NotifierProvider<ProfileNotifier, ProfileResponse>(
    () {return ProfileNotifier();}
);

class _ProfileScreen extends ConsumerState<ProfileScreen>{

  final GlobalKey<LoadingDialogState> loadingDialogKey = GlobalKey<LoadingDialogState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) {
      requestProfileData();
    });

      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top:35.0, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft, child: Text ("Perfil de usuario", style: Theme.of(context).textTheme.displayLarge)),
              Divider(),
              SizedBox(height: 20),
              getTextField(userController, "Usuario", "Nombre de usuario", null, false),
              SizedBox(height: 20),
              getTextField(passwordController, "Contraseña", "", null, true),
              SizedBox(height: 20),
              getTextField(emailController, "Email", "", null, false),
              SizedBox(height: 20),
              Center(child: ElevatedButton(
                  onPressed: (){},
                  child: Text("ACTUALIZAR")))
            ],
          ),
        )
      );
  }

  Widget getTextField(TextEditingController controller, String labelText, String hintText, IconData? icon, bool isObscure){
    return SizedBox(
      width: 300,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.blue),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: icon!=null ? Icon(icon, color: Colors.blue) : null,
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

  void requestProfileData() async {

      var error = false;

      try {
        showLoadingDialog();
        await ref.read(profileNotifier.notifier).fetchUserData();
      } catch (e){
        error = true;
        print ("EPS!");
      } finally {
        print ("EPS2");
        await loadingDialogKey.currentState?.stopLoading(context);
      }

      if (error) {
        print ("EPS3");
        showError();
      } else {
        final provider = ref.watch(profileNotifier);
        userController.text = provider.user;
        passwordController.text = provider.password;
        emailController.text = provider.email;
      }
  }

}
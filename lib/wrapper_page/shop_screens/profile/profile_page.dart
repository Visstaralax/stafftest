import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/commons/dialog_type.dart';
import 'package:staffseidorapptest/commons/general_dialog.dart';
import 'package:staffseidorapptest/commons/loading_widget/loading_dialog.dart';
import 'package:staffseidorapptest/commons/loading_widget/loading_manager.dart';

import 'model/profile_response.dart';
import 'notifier/profile_notifier.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileResponse>((ref) {
  return ProfileNotifier();
});

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>{

  final GlobalKey<LoadingDialogState> loadingDialogKey = GlobalKey<LoadingDialogState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _requestProfileData();
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

  Widget getTextField(TextEditingController controller, String labelText, String hintText, IconData? icon, bool isObscure) {
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
          prefixIcon: icon != null ? Icon(icon, color: Colors.blue) : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0, horizontal: 20.0),
        ),
      ),
    );
  }

  void _requestProfileData() async {

      LoadingManager.showLoadingDialog(context, loadingDialogKey);
      await ref.read(profileProvider.notifier).fetchUserData();
      if (context.mounted) {
        LoadingManager.stopLoading(context, loadingDialogKey);
      }

      print ("ref.watch(profileProvider).error");
      print (ref.watch(profileProvider).error);

      if (ref.watch(profileProvider).error) {
        if (context.mounted) {
          LoadingManager.showError(context);
        }
      } else {
          final provider = ref.watch(profileProvider);
          userController.text = provider.user;
          passwordController.text = provider.password;
          emailController.text = provider.email;
      }
  }

}
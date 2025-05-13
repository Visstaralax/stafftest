import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staffseidorapptest/commons/logout/logout_notifier.dart';

final logoutUseCase = StateNotifierProvider<LogoutNotifier, void>((ref){
  return LogoutNotifier();
});
class DialogLogout extends ConsumerStatefulWidget {
  const DialogLogout({super.key});

  @override
  ConsumerState<DialogLogout> createState() => DialogLogoutState();
}

class DialogLogoutState extends ConsumerState<DialogLogout> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _confirmLogout();
    });

    super.initState();
  }
  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            icon: Icon(Icons.exit_to_app_rounded),
            title: const Text('Cerrar sesión'),
            content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text('Cerrar sesión'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
    );

    if (shouldLogout == true) {
      if (context.mounted) {
        await _performLogout(context, ref);
      }
    }
  }

  Future<void> _performLogout(BuildContext context, WidgetRef ref) async {
    await ref.read(logoutUseCase.notifier).call(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
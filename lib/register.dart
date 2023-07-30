import 'package:auth/auth_provider.dart';
import 'package:auth/home.dart';
import 'package:auth/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Register extends ConsumerWidget {
  Register({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                ),
                TextFormField(
                  controller: emailController,
                ),
                TextFormField(
                  controller: passwordController,
                ),
                TextButton(
                    onPressed: () {
                      authNotifier
                          .signupWithEmailAndPassword(emailController.text,
                              passwordController.text, nameController.text)
                          .then((value) {
                        context.navigateToScreen(
                            child: const Home(), isReplace: true);
                      });
                    },
                    child: const Text('Register'))
              ],
            ),
            authNotifier.isLoading
                ? const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

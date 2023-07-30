import 'package:auth/auth_provider.dart';
import 'package:auth/home.dart';
import 'package:auth/register.dart';
import 'package:auth/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
            ),
            TextFormField(
              controller: passwordController,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: const Text('Register')),
            TextButton(
                onPressed: () {
                  authNotifier
                      .loginUserWithFirebase(
                          emailController.text, passwordController.text)
                      .then((value) {
                    context.navigateToScreen(
                        child: const Home(), isReplace: true);
                  });
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}

import 'package:auth/auth_provider.dart';
import 'package:auth/login_page.dart';
import 'package:auth/utils/context_extension.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Consumer(builder: (context, ref, child) {
            final authNotifier = ref.watch(authProvider);

            return IconButton(
                onPressed: () {
                  authNotifier.logoutUser();
                  context.navigateToScreen(isReplace: true, child: LoginPage());
                },
                icon: const Icon(Icons.exit_to_app));
          })
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                // FirebaseFirestore.instance
                //     .collection('users')
                //     .doc(FirebaseAuth.instance.currentUser!.uid)
                //     .snapshots()
                //     .forEach((element) {
                //   print(element.get('name'));
                // });
                authNotifier
                    .getDataUser(
                        'users', FirebaseAuth.instance.currentUser!.uid)
                    .asStream();
              },
              child: const Text('UID')),
        )
      ]),
    );
  }
}

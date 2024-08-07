import 'package:flix_id/presentation/extentions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/constans.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widget/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [ConsumerWidget] that represents the login page of the application.
///
/// This widget provides the user interface for logging in to the application.
/// It includes text fields for email and password, a button for logging in,
/// and options to navigate to the registration page or reset the password.
class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listens to changes in the [userDataProvider] and navigates to the main page
    // if the user is logged in, or shows a snack bar with an error message otherwise.
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed('main');
          }
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                verticalSpace(100),
                Center(
                  child: Image.asset(
                    'assets/flix_logo.png',
                    width: 150,
                  ),
                ),
                verticalSpace(100),
                FlixTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpace(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                verticalSpace(24),
                // Displays a login button or a loading indicator based on the
                // state of [userDataProvider].
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(userDataProvider.notifier).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const CircularProgressIndicator(),
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('register');
                      },
                      child: const Text(
                        'Register here',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                /* switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? ElevatedButton(
                          onPressed: () {
                            ref.read(userDataProvider.notifier).loginSSO();
                          },
                          child: const Text('Login google'))
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const CircularProgressIndicator(),
                }*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}

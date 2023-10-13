import 'package:flix_id/presentation/extentions/build_context_extension.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widget/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController retypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref.read(routerProvider).goNamed('main');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              verticalSpace(50.0),
              Image.asset(
                'assets/flix_logo.png',
                width: 150.0,
              ),
              verticalSpace(50.0),
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              verticalSpace(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    FlixTextField(labelText: 'Email', controller: emailController),
                    verticalSpace(24),
                    FlixTextField(labelText: 'Name', controller: nameController),
                    verticalSpace(24),
                    FlixTextField(
                      labelText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    verticalSpace(24),
                    FlixTextField(
                      labelText: 'Retype password',
                      controller: retypeController,
                      obscureText: true,
                    ),
                    verticalSpace(24),
                    switch (ref.watch(userDataProvider)) {
                      AsyncData(:final value) => value == null
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (passwordController.text == retypeController.text) {
                                      ref.read(userDataProvider.notifier).register(
                                            email: emailController.text,
                                            name: nameController.text,
                                            password: passwordController.text,
                                            imageUrl: '',
                                          );
                                    } else {
                                      context.showSnackBar('Please retype your password with the same value');
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      _ => const CircularProgressIndicator()
                    }
                  ],
                ),
              ),
              verticalSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                  ),
                  TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('login');
                      },
                      child: const Text(
                        'Login here',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

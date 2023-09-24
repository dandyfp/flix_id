import 'package:flix_id/domain/usecases/login/login.dart';
import 'package:flix_id/presentation/pages/main_page/main_page.dart';
import 'package:flix_id/presentation/providers/usecase/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Login login = ref.watch(loginProvider);
            login(LoginParams(email: 'dandy@gmail.com', password: 'dandy123')).then(
              (value) => {
                if (value.isSuccess)
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MainPage(user: value.resultValue!),
                    ))
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value.errorMessagge!),
                      ),
                    ),
                  }
              },
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

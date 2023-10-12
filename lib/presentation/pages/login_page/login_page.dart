import 'package:flix_id/presentation/extentions/build_context_extension.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(userDataProvider.notifier).login(email: 'dandy@gmail.com', password: 'dandy123');
            /* 
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
            ); */
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

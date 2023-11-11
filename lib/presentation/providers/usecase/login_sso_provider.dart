import 'package:flix_id/domain/usecases/login_SSO/login_sso.dart';
import 'package:flix_id/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_sso_provider.g.dart';

@riverpod
LoginSSO loginSSO(LoginSSORef ref) => LoginSSO(
      authentication: ref.watch(authenticationProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );

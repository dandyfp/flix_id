import 'package:flix_id/data/repositories/authentication.dart';
import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class LoginSSO implements UseCase<Result<User>, void> {
  final Authentication authentication;
  final UserRepository userRepository;
  LoginSSO({
    required this.authentication,
    required this.userRepository,
  });
  @override
  Future<Result<User>> call(void params) async {
    var result = await authentication.loginSSO();
    if (result is Success) {
      var userResult = await userRepository.getUser(uid: result.resultValue!);
      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message),
      };
    } else {
      return Result.failed(result.errorMessagge ?? '');
    }
  }
}
